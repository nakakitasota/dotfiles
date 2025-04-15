import { BaseConfig, ConfigArguments } from "jsr:@shougo/ddc-vim@~9.4.0/config";

export class Config extends BaseConfig {
    override async config(args: ConfigArguments): Promise<void> {
        const sources = [
            "lsp",
            "vsnip",
            "around",
            "file",
        ];

        args.contextBuilder.patchGlobal({
            ui: "pum",
            sources: sources,
            sourceOptions: {
                _: {
                    ignoreCase: true,
                    matchers: ["matcher_head"],
                    sorters: ["sorter_rank"],
                    minAutoCompleteLength: 1,
                },
                lsp: {
                    converters: ["converter_kind_labels"],
                    mark: "L",
                    forceCompletionPattern: String.raw`\.\w*|:\w*|->\w*`,
                },
                vsnip: {
                    converters: ["converter_kind_labels"],
                    mark: "A",
                },
                around: {
                    mark: "A",
                },
                file: {
                    mark: "F",
                    isVolatile: true,
                    forceCompletionPattern: String.raw`\S/\S*`,
                },
            },
            sourceParams: {
                lsp: {
                    snippetEngine: await args.denops.eval(
                        "denops#callback#register({ body -> vsnip#anonymous(body) })",
                    ),
                    enableResolveItem: true,
                    enableAdditionalTextEdit: true,
                },
                file: {
                    displayFile: "",
                    displayDir: "",
                    displaySym: "",
                    displaySymFile: "",
                    displaySymDir: "",
                },
            },
            filterParams: {
                converter_kind_labels: {
                    kindLabels: {
                        Text: "",
                        Method: "",
                        Function: "",
                        Constructor: "",
                        Field: "",
                        Variable: "",
                        Class: "",
                        Interface: "",
                        Module: "",
                        Property: "",
                        Unit: "",
                        Value: "",
                        Enum: "",
                        Keyword: "",
                        Snippet: "",
                        Color: "",
                        File: "",
                        Reference: "",
                        Folder: "",
                        EnumMember: "",
                        Constant: "",
                        Struct: "",
                        Event: "",
                        Operator: "",
                        TypeParameter: "",
                    },
                },
            },
        });

        for (
            const ft of [
                "ps1",
                "dosbatch",
                "autohotkey",
                "registry",
            ]
        ) {
            args.contextBuilder.patchFiletype(ft, {
                sourceOptions: {
                    file: {
                        forceCompletionPattern: String.raw`\S\\\S*`,
                    },
                },
                sourceParams: {
                    file: {
                        mode: "win32",
                    },
                },
            });
        }
    }
}
