return {
  "AstroNvim/astrolsp",
  optional = true,
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    require("astrocore").extend_tbl(opts.config, {
      intelephense = {
        root_dir = function(_) return vim.loop.cwd() end,
        settings = {
          intelephense = {
            files = {
              maxSize = 1000000,
            },
            stubs = {
              "apache",
              "bcmath",
              "bz2",
              "calendar",
              "com_dotnet",
              "Core",
              "ctype",
              "curl",
              "date",
              "dba",
              "dom",
              "enchant",
              "exif",
              "FFI",
              "fileinfo",
              "filter",
              "fpm",
              "ftp",
              "gd",
              "gettext",
              "gmp",
              "hash",
              "iconv",
              "imap",
              "imagick",
              "intl",
              "json",
              "ldap",
              "libxml",
              "mbstring",
              "memcache",
              "memcached",
              "meta",
              "mysqli",
              "oci8",
              "odbc",
              "openssl",
              "yar",
              "yaconf",
              "pcntl",
              "pcre",
              "PDO",
              "pdo_ibm",
              "pdo_mysql",
              "pdo_pgsql",
              "pdo_sqlite",
              "pgsql",
              "Phar",
              "posix",
              "pspell",
              "readline",
              "redis",
              "Reflection",
              "session",
              "shmop",
              "SimpleXML",
              "snmp",
              "soap",
              "sockets",
              "sodium",
              "SPL",
              "sqlite3",
              "standard",
              "superglobals",
              "sysvmsg",
              "sysvsem",
              "sysvshm",
              "tidy",
              "tokenizer",
              "xml",
              "xmlreader",
              "xmlrpc",
              "xmlwriter",
              "xsl",
              "yaf",
              "yar",
              "Zend OPcache",
              "zip",
              "zlib",
            },
            format = { enable = false, braces = "k&r" },
            diagnostics = {
              run = "onSave",
            },
            telemetry = { enabled = false },
          },
        },
      },
    })
  end,
}
