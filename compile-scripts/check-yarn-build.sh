PREFIX=$(TURBO_NO_UPDATE_NOTIFIER=1 TURBO_PRINT_VERSION_DISABLED=1 yarn turbo ls 2>&1 | awk '/@/ {print $1; exit}' | sed 's|/.*||')
yarn turbo run build --output-logs=errors-only 2>&1 | grep ^$PREFIX | sed -E "s|:[^ ]+ |/|; s|^$PREFIX|packages|; s|\\(([0-9]+),([0-9]+)\\)|:\\1:\\2|" | grep src
