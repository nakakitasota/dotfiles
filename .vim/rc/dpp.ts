import type { Denops } from "jsr:@denops/std@~7.5.0";
import {
    ContextBuilder,
    ExtOptions,
    Plugin,
} from "jsr:@shougo/dpp-vim@~4.2.0/types";
import { BaseConfig, ConfigReturn } from "jsr:@shougo/dpp-vim@~4.2.0/config";
import { Protocol } from "jsr:@shougo/dpp-vim@~4.2.0/protocol";
import { mergeFtplugins } from "jsr:@shougo/dpp-vim@~4.2.0/utils";
import type {
    Ext as LazyExt,
    LazyMakeStateResult,
    Params as LazyParams,
} from "jsr:@shougo/dpp-ext-lazy@~1.5.0";
import type {
    Ext as TomlExt,
    Params as TomlParams,
} from "jsr:@shougo/dpp-ext-toml@~1.3.0";

export class Config extends BaseConfig {
    override async config(args: {
        denops: Denops;
        contextBuilder: ContextBuilder;
        basePath: string;
    }): Promise<ConfigReturn> {
        args.contextBuilder.setGlobal({
            protocols: ["git"],
        });

        const [context, options] = await args.contextBuilder.get(args.denops);
        const protocols = await args.denops.dispatcher.getProtocols() as Record<
            string,
            Protocol
        >;
        const BASE_DIR = "~/.vim/rc";
        const hasNvim = args.denops.meta.host === "nvim";

        const recordPlugins: Record<string, Plugin> = {};
        const ftplugins: Record<string, string> = {};
        const hooksFiles: string[] = [];

        // Load toml plugins
        const [tomlExt, tomlOptions, tomlParams]: [
            TomlExt | undefined,
            ExtOptions,
            TomlParams,
        ] = await args.denops.dispatcher.getExt(
            "toml",
        ) as [TomlExt | undefined, ExtOptions, TomlParams];

        if (tomlExt) {
            const action = tomlExt.actions.load;

            const tomlFiles = [
                { path: `${BASE_DIR}/dpp.toml`, lazy: false },
                { path: `${BASE_DIR}/non_lazy.toml`, lazy: false },
                { path: `${BASE_DIR}/lazy.toml`, lazy: true },
                { path: `${BASE_DIR}/fern.toml`, lazy: true },
                { path: `${BASE_DIR}/ddu.toml`, lazy: true },
                { path: `${BASE_DIR}/ddc.toml`, lazy: true },
            ];

            if (hasNvim) {
                tomlFiles.push(
                    {
                        path: `${BASE_DIR}/nvim-lsp.toml`,
                        lazy: true,
                    },
                );
            }

            const tomlPromises = tomlFiles.map((tomlFile) => {
                return action.callback({
                    denops: args.denops,
                    context,
                    options,
                    protocols,
                    extOptions: tomlOptions,
                    extParams: tomlParams,
                    actionParams: {
                        path: tomlFile.path,
                        options: {
                            lazy: tomlFile.lazy,
                        },
                    },
                });
            });
            const tomls = await Promise.all(tomlPromises);

            // Merge toml results
            for (const toml of tomls) {
                for (const plugin of toml.plugins ?? []) {
                    recordPlugins[plugin.name] = plugin;
                }

                if (toml.ftplugins) {
                    mergeFtplugins(ftplugins, toml.ftplugins);
                }

                if (toml.hooks_file) {
                    hooksFiles.push(toml.hooks_file);
                }
            }
        }

        const [lazyExt, lazyOptions, lazyParams]: [
            LazyExt | undefined,
            ExtOptions,
            LazyParams,
        ] = await args.denops.dispatcher.getExt(
            "lazy",
        ) as [LazyExt | undefined, ExtOptions, LazyParams];

        let lazyResult: LazyMakeStateResult | undefined = undefined;

        if (lazyExt) {
            const action = lazyExt.actions.makeState;

            lazyResult = await action.callback({
                denops: args.denops,
                context,
                options,
                protocols,
                extOptions: lazyOptions,
                extParams: lazyParams,
                actionParams: {
                    plugins: Object.values(recordPlugins),
                },
            });
        }

        return {
            ftplugins,
            hooksFiles,
            plugins: lazyResult?.plugins ?? [],
            stateLines: lazyResult?.stateLines ?? [],
        };
    }
}
