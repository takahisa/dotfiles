"use strict";

module.exports = {
  config: {
    // Update from 'stable' channels
    updateChannel: 'stable',

    // Disable sound notification
    bell: false,

    // Set the space around each terminal
    padding: '12px 25px',

    // Use bash for login shell
    shell: '/bin/bash',
    shellArgs: ['--login'],
    env: {
      SHELL: '/bin/bash' 
    },
    // Font settings
    fontFamily: '"Hack Nerd Font Mono", Hack, monospace',
    fontWeight: 'normal',
    fontWeightBold: 'bold',
    fontSize: 18,

    // Key settings    
    modifierKeys: {
      // ALT to META (for Emacs)
      altIsMeta: true
    },

    // Plugin: hyperborder
    hyperBorder: {
      borderColors: ['#6272a4', '#ff79c6', '#bd93f9'],
      borderWidth: '8px'
    }
  },
  plugins: ["hyper-flat", 'hyperborder', 'hyper-dracula'],
};
