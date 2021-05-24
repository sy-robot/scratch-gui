#!/bin/sh

LF=$(printf '\\\012_')
LF=${LF%_}

mkdir -p node_modules/scratch-vm/src/extensions/scratch3_dochi
cp dochi/scratch-vm/src/extensions/scratch3_dochi/index.js node_modules/scratch-vm/src/extensions/scratch3_dochi/
mv node_modules/scratch-vm/src/extension-support/extension-manager.js node_modules/scratch-vm/src/extension-support/extension-manager.js_orig
sed -e "s|class ExtensionManager {$|builtinExtensions['dochi'] = () => require('../extensions/scratch3_dochi');${LF}${LF}class ExtensionManager {|g" node_modules/scratch-vm/src/extension-support/extension-manager.js_orig > node_modules/scratch-vm/src/extension-support/extension-manager.js

mkdir -p src/lib/libraries/extensions/dochi
cp dochi/scratch-gui/src/lib/libraries/extensions/dochi/dochi.png src/lib/libraries/extensions/dochi/
cp dochi/scratch-gui/src/lib/libraries/extensions/dochi/dochi-small.svg src/lib/libraries/extensions/dochi/
mv src/lib/libraries/extensions/index.jsx src/lib/libraries/extensions/index.jsx_orig
DESCRIPTION="\
    {${LF}\
        name: 'dochi',${LF}\
        extensionId: 'dochi',${LF}\
        collaborator: 'SYRobot',${LF}\
        iconURL: dochiIconURL,${LF}\
        insetIconURL: dochiInsetIconURL,${LF}\
        description: (${LF}\
            <FormattedMessage${LF}\
                defaultMessage='Control Dochi Robot.'${LF}\
                description='Control Dochi Robot.'${LF}\
                id='gui.extension.dochiblocks.description'${LF}\
            />${LF}\
        ),${LF}\
        featured: true,${LF}\
        disabled: false,${LF}\
        bluetoothRequired: true,${LF}\
        internetConnectionRequired: false,${LF}\
        launchPeripheralConnectionFlow: true,${LF}\
        useAutoScan: false,${LF}\
        helpLink: 'https://champierre.github.io/dochi/'${LF}\
    },"
sed -e "s|^export default \[$|import dochiIconURL from './dochi/dochi.png';${LF}import dochiInsetIconURL from './dochi/dochi-small.svg';${LF}${LF}export default [${LF}${DESCRIPTION}|g" src/lib/libraries/extensions/index.jsx_orig > src/lib/libraries/extensions/index.jsx
