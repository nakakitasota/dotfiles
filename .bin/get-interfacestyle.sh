#!/bin/sh

case `uname` in
    "Linux")
        type "gsettings" > /dev/null 2>&1 || exit 1
        case `gsettings get org.gnome.desktop.interface color-scheme` in
            "'prefer-dark'")
                echo "Dark"
                exit 0
            ;;
            "'prefer-light'")
                echo "Light"
                exit 0
            ;;
            *)
                exit 1
            ;;
        esac
    ;;
    "Darwin")
        if defaults read -g AppleInterfaceStyle > /dev/null 2>&1; then
            echo "Dark"
        else
            echo "Light"
        fi
        exit 0
    ;;
    *)
        exit 1
    ;;
esac
