#!/bin/sh

version=3.4

brew_llvm_config=/usr/local/Cellar/llvm/3.4.*/bin/llvm-config
if [ ! -x $brew_llvm_config ]
then
    brew_llvm_config=
fi

common_configure="./configure CC=gcc CXX=g++ --prefix=$2 --disable-doxygen --disable-docs --enable-static --with-ocaml-libdir=$3/llvm"

for config in llvm-config-$version llvm-config-mp-$version $brew_llvm_config llvm-config; do
    case `$config --version` in
        $version|$version.*)
            case `uname -s` in
                Darwin)
                    $common_configure --disable-shared;;
                *)
                    $common_configure --enable-shared;;
            esac
            $1 -C bindings/ocaml build SYSTEM_LLVM_CONFIG="$config"
            $1 -C bindings/ocaml install SYSTEM_LLVM_CONFIG="$config"
            cp "$3/llvm/META.llvm" "$3/llvm/META"
            exit 0;;
        *)
            continue;;
    esac
done

echo "Error: LLVM is not installed."
exit 1
