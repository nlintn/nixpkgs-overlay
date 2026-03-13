{ buildMozillaXpiAddon, fetchurl, lib, stdenv }:
  {
    "darkreader" = buildMozillaXpiAddon {
      pname = "darkreader";
      version = "4.9.123";
      addonId = "addon@darkreader.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4710145/darkreader-4.9.123.xpi";
      sha256 = "9a3e6cdac53f20257bd81264532c16afedad00eb2623bded89ed2b30b1e40243";
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
    "dictionary-german" = buildMozillaXpiAddon {
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
    "keepassxc-browser" = buildMozillaXpiAddon {
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
    "simplelogin" = buildMozillaXpiAddon {
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
    "tabwrangler" = buildMozillaXpiAddon {
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
    "ublock-origin" = buildMozillaXpiAddon {
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
    "video-downloadhelper" = buildMozillaXpiAddon {
      pname = "video-downloadhelper";
      version = "10.2.5.2";
      addonId = "{b9db16a4-6edc-47ec-a1f4-b86292ed211d}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4714322/video_downloadhelper-10.2.5.2.xpi";
      sha256 = "9653585ea05aefd24ccb933a8778bb9cb8a014f4ee2f73cfb3e08738b1acf5b6";
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
    "vimium-ff" = buildMozillaXpiAddon {
      pname = "vimium-ff";
      version = "2.4.0";
      addonId = "{d7742d87-e61d-4b78-b8a1-b469842139fa}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4698049/vimium_ff-2.4.0.xpi";
      sha256 = "9ad35d0857031770e5c2f419789a5dfa8ea2fa3de7056c1dd32ca0bc81bb4d37";
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
    "violentmonkey" = buildMozillaXpiAddon {
      pname = "violentmonkey";
      version = "2.35.0";
      addonId = "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4704557/violentmonkey-2.35.0.xpi";
      sha256 = "00d6ed07f730e4f5e15395d9a204ea91dff4e06e70c51f0df11edf54dc645ec9";
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
    "zen-internet" = buildMozillaXpiAddon {
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