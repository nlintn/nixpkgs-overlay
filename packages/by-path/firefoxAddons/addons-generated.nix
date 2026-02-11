{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "darkreader" = buildFirefoxXpiAddon {
      pname = "darkreader";
      version = "4.9.120";
      addonId = "addon@darkreader.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4690081/darkreader-4.9.120.xpi";
      sha256 = "496bf5a0e4a4d26226528ecce0ae051ee3f23153ee48d504d51f0f22afaf0fdd";
      meta = with lib;
      {
        homepage = "https://darkreader.org/";
        description = "Dark mode for every website. Take care of your eyes, use dark theme for night and daily browsing.";
        license = licenses.mit;
        mozPermissions = [
          "alarms"
          "contextMenus"
          "storage"
          "tabs"
          "theme"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
    "dictionary-german" = buildFirefoxXpiAddon {
      pname = "dictionary-german";
      version = "2.1";
      addonId = "de-DE@dictionaries.addons.mozilla.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4034565/dictionary_german-2.1.xpi";
      sha256 = "00ef6eb3c10171a87fb22ab6e516846678b73c56ae828cc19d11e32e43b8457a";
      meta = with lib;
      {
        description = "German Dictionary (new Orthography) for spellchecking in Firefox";
        license = licenses.lgpl21;
        mozPermissions = [];
        platforms = platforms.all;
      };
    };
    "keepassxc-browser" = buildFirefoxXpiAddon {
      pname = "keepassxc-browser";
      version = "1.9.11";
      addonId = "keepassxc-browser@keepassxc.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4628286/keepassxc_browser-1.9.11.xpi";
      sha256 = "bee523ac8d968d36ae3ae317b12b1b2bbe85e2c6f5b9ddb0fb822c2d90af6139";
      meta = with lib;
      {
        homepage = "https://keepassxc.org/";
        description = "Official browser plugin for the KeePassXC password manager (https://keepassxc.org).";
        license = licenses.gpl3;
        mozPermissions = [
          "activeTab"
          "clipboardWrite"
          "contextMenus"
          "cookies"
          "nativeMessaging"
          "notifications"
          "storage"
          "tabs"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
          "https://*/*"
          "http://*/*"
          "https://api.github.com/"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
    "simplelogin" = buildFirefoxXpiAddon {
      pname = "simplelogin";
      version = "3.0.7";
      addonId = "addon@simplelogin";
      url = "https://addons.mozilla.org/firefox/downloads/file/4458602/simplelogin-3.0.7.xpi";
      sha256 = "8e91d0b7e2bc76746818dd8cc533ea525b9c3cfd433fba52da4766a83f579ded";
      meta = with lib;
      {
        homepage = "https://simplelogin.io";
        description = "Create a different email for each website to hide your real email. Guard your inbox against spams, phishing. Protect your privacy.";
        license = licenses.mit;
        mozPermissions = [
          "activeTab"
          "storage"
          "contextMenus"
          "scripting"
          "tabs"
          "http://*/*"
          "https://*/*"
        ];
        platforms = platforms.all;
      };
    };
    "tabwrangler" = buildFirefoxXpiAddon {
      pname = "tabwrangler";
      version = "7.8.0";
      addonId = "{81b74d53-9416-4fb3-afa2-ab46684b253b}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4438127/tabwrangler-7.8.0.xpi";
      sha256 = "1371955dc30d64c664ea8f644b95615dd5c44997bb7456457089c58941eecf69";
      meta = with lib;
      {
        homepage = "https://github.com/tabwrangler/tabwrangler/";
        description = "Automatically closes inactive tabs and makes it easy to get them back";
        license = licenses.mit;
        mozPermissions = [
          "alarms"
          "contextMenus"
          "sessions"
          "storage"
          "tabs"
        ];
        platforms = platforms.all;
      };
    };
    "ublock-origin" = buildFirefoxXpiAddon {
      pname = "ublock-origin";
      version = "1.69.0";
      addonId = "uBlock0@raymondhill.net";
      url = "https://addons.mozilla.org/firefox/downloads/file/4675310/ublock_origin-1.69.0.xpi";
      sha256 = "785bcde68a25faa8a0949964ec5ffe9bdcb85d3f0ae21c23f607c6c8f91472cf";
      meta = with lib;
      {
        homepage = "https://github.com/gorhill/uBlock#ublock-origin";
        description = "Finally, an efficient wide-spectrum content blocker. Easy on CPU and memory.";
        license = licenses.gpl3;
        mozPermissions = [
          "alarms"
          "dns"
          "menus"
          "privacy"
          "storage"
          "tabs"
          "unlimitedStorage"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
          "<all_urls>"
          "http://*/*"
          "https://*/*"
          "file://*/*"
          "https://easylist.to/*"
          "https://*.fanboy.co.nz/*"
          "https://filterlists.com/*"
          "https://forums.lanik.us/*"
          "https://github.com/*"
          "https://*.github.io/*"
          "https://github.com/uBlockOrigin/*"
          "https://ublockorigin.github.io/*"
          "https://*.reddit.com/r/uBlockOrigin/*"
        ];
        platforms = platforms.all;
      };
    };
    "video-downloadhelper" = buildFirefoxXpiAddon {
      pname = "video-downloadhelper";
      version = "10.1.37.2";
      addonId = "{b9db16a4-6edc-47ec-a1f4-b86292ed211d}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4666829/video_downloadhelper-10.1.37.2.xpi";
      sha256 = "d03856480b1cd8d955571140065ceddc4d704c096c3327dd04737aff1299547b";
      meta = with lib;
      {
        homepage = "http://www.downloadhelper.net/";
        description = "Download videos from the web. Easy, smart, no tracking.";
        mozPermissions = [
          "tabs"
          "downloads"
          "webRequest"
          "webNavigation"
          "scripting"
          "declarativeNetRequest"
          "storage"
          "notifications"
          "contextMenus"
          "*://*.youtube.com/*"
          "*://*.vimeo.com/*"
          "*://*.facebook.com/*"
          "*://*.instagram.com/*"
          "*://*.ok.ru/*"
          "*://*.m.ok.ru/*"
          "*://vk.com/*"
          "*://vk.ru/*"
          "*://vkvideo.ru/*"
          "*://live.vkvideo.ru/*"
          "*://*.canva.com/*"
          "*://*.iq.com/*"
          "*://*.twitcasting.tv/*"
          "https://v10.downloadhelper.net/activate*"
          "https://app.v10.downloadhelper.net/activate*"
          "https://v10.downloadhelper.net/changelog*"
          "https://app.v10.downloadhelper.net/changelog*"
        ];
        platforms = platforms.all;
      };
    };
    "vimium-ff" = buildFirefoxXpiAddon {
      pname = "vimium-ff";
      version = "2.3.1";
      addonId = "{d7742d87-e61d-4b78-b8a1-b469842139fa}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4618554/vimium_ff-2.3.1.xpi";
      sha256 = "2c1b861cb41939c2a26e4e60b95d1e74e465e807c2c549a30c909c1923591473";
      meta = with lib;
      {
        homepage = "https://github.com/philc/vimium";
        description = "The Hacker's Browser. Vimium provides keyboard shortcuts for navigation and control in the spirit of Vim.";
        license = licenses.mit;
        mozPermissions = [
          "tabs"
          "bookmarks"
          "history"
          "storage"
          "sessions"
          "notifications"
          "scripting"
          "webNavigation"
          "search"
          "clipboardRead"
          "clipboardWrite"
          "<all_urls>"
          "file:///"
          "file:///*/"
        ];
        platforms = platforms.all;
      };
    };
    "violentmonkey" = buildFirefoxXpiAddon {
      pname = "violentmonkey";
      version = "2.34.0";
      addonId = "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4677263/violentmonkey-2.34.0.xpi";
      sha256 = "ac58eb2796765da73db571a9491352acbb8287b76ccd9e2375612364a4cd5473";
      meta = with lib;
      {
        homepage = "https://violentmonkey.github.io/";
        description = "Userscript support for browsers, open source.";
        license = licenses.mit;
        mozPermissions = [
          "tabs"
          "<all_urls>"
          "webRequest"
          "webRequestBlocking"
          "notifications"
          "storage"
          "unlimitedStorage"
          "clipboardWrite"
          "contextMenus"
          "cookies"
        ];
        platforms = platforms.all;
      };
    };
    "zen-internet" = buildFirefoxXpiAddon {
      pname = "zen-internet";
      version = "2.7.0";
      addonId = "{91aa3897-2634-4a8a-9092-279db23a7689}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4537733/zen_internet-2.7.0.xpi";
      sha256 = "3c43e841136388eea54a3bf9c993482b5eaa62025a7895a852abaa6c4651d35a";
      meta = with lib;
      {
        homepage = "https://www.sameerasw.com";
        description = "Inject custom css to make the web beautiful in Zen Browser";
        license = licenses.mit;
        mozPermissions = [
          "activeTab"
          "storage"
          "tabs"
          "<all_urls>"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
        ];
        platforms = platforms.all;
      };
    };
  }