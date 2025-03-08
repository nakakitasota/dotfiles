user_pref("general.useragent.locale", "ja"); // Webページ表示言語
user_pref("font.cjk_pref_fallback_order", "ja,zh-cn,zh-hk,zh-tw,ko"); // Font fallback order for Japanese
user_pref("general.autoScroll", true); // Enable auto-scrolling
user_pref("browser.startup.homepage", "https://calendar.google.com/calendar/u/0/r");
user_pref("browser.shell.checkDefaultBrowser", false); // 起動時に既定のブラウザを確認しない
user_pref("browser.startup.page", 1); // 起動時に前回終了時のページを復元しない
user_pref("browser.download.useDownloadDir", false); // ダウンロードディレクトリを毎回指定する
user_pref("browser.tabs.loadInBackground", true); // 新しいタブを裏で開く
user_pref("app.update.auto", false); // Firefox本体の自動アップデートに抵抗
user_pref("browser.search.update", false); // 検索エンジンの自動アップデートに抵抗
user_pref("browser.search.suggest.enabled", false); // アドレスバーへの入力時に検索候補を表示しない
user_pref("signon.rememberSignons", false); // 標準のパスワードマネージャーを無効化
user_pref("privacy.trackingprotection.enabled", true); // トラッキング保護を常に有効化
user_pref("privacy.trackingprotection.fingerprinting.enabled", true); // トラッキング保護を厳格に設定
user_pref("privacy.donottrackheader.enabled", true); // DoNotTrackヘッダを送信
// user_pref("browser.uidensity", 1); // UI密度設定「コンパクト」を使用
user_pref("browser.newtabpage.enabled", false); // 新しいタブを空白ページにする

user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // ユーザースタイルを有効化
user_pref("beacon.enabled", false); // ビーコンを無効化
user_pref("browser.pocket.enabled", false); // Pocketを無効にする
user_pref("reader.parse-on-load.enabled", false); // リーダービューを無効にする
user_pref("full-screen-api.warning.timeout", 0); // HTML5動画のフルスクリーン警告非表示
user_pref("middlemouse.paste", true); // テキストボックス上を中クリックで貼り付け
user_pref("middlemouse.scrollbarPosition", true); // スクロールバー上を中クリックでその位置までショートカット
user_pref("nglayout.events.dispatchLeftClickOnly", true); // 右クリック禁止設定に抵抗
user_pref("browser.link.open_newwindow.restriction", 0); // ポップアップウィンドウを強制的にタブでオープン
user_pref("browser.zoom.updateBackgroundTabs", true); // ページの拡大を別タブの同サイトに反映しない
user_pref("browser.ctrlTab.previews", false); // Ctrl-Tabのプレビューを無効化
user_pref("browser.ctrlTab.recentlyUsedOrder", false); // Ctrl-Tabで次のタブに切り替える（最近使用したタブに切り替えない）
user_pref("ui.prefersReducedMotion", 0); // Fx80以降でアニメーション効果を削除しない

// テレメトリ無効化
user_pref("datareporting.healthreport.logging.consoleEnabled", false);
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.unifiedIsOptIn", false);

// Direct2D描画オプション(For Mactype)
// user_pref("gfx.direct2d.disabled", true);
// user_pref("gfx.canvas.azure.backends", "direct2d1.1,skia,cairo");
// user_pref("gfx.content.azure.backends", "direct2d1.1,skia,cairo");
