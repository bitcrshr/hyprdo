// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/hyprdo_web.ex",
    "../lib/hyprdo_web/**/*.*ex"
  ],
  theme: {
    extend: {
      fontSize: {
        sm: '0.750rem',
        base: '1rem',
        xl: '1.333rem',
        '2xl': '1.777rem',
        '3xl': '2.369rem',
        '4xl': '3.158rem',
        '5xl': '4.210rem',
      },
      fontFamily: {
        heading: 'Inter',
        body: 'Inter',
      },
      fontWeight: {
        normal: '400',
        bold: '700',
      },
      colors: {
        'text': {
           50: 'var(--text-50)',
           100: 'var(--text-100)',
           200: 'var(--text-200)',
           300: 'var(--text-300)',
           400: 'var(--text-400)',
           500: 'var(--text-500)',
           600: 'var(--text-600)',
           700: 'var(--text-700)',
           800: 'var(--text-800)',
           900: 'var(--text-900)',
           950: 'var(--text-950)',
         },
         'background': {
           50: 'var(--background-50)',
           100: 'var(--background-100)',
           200: 'var(--background-200)',
           300: 'var(--background-300)',
           400: 'var(--background-400)',
           500: 'var(--background-500)',
           600: 'var(--background-600)',
           700: 'var(--background-700)',
           800: 'var(--background-800)',
           900: 'var(--background-900)',
           950: 'var(--background-950)',
         },
         'primary': {
           50: 'var(--primary-50)',
           100: 'var(--primary-100)',
           200: 'var(--primary-200)',
           300: 'var(--primary-300)',
           400: 'var(--primary-400)',
           500: 'var(--primary-500)',
           600: 'var(--primary-600)',
           700: 'var(--primary-700)',
           800: 'var(--primary-800)',
           900: 'var(--primary-900)',
           950: 'var(--primary-950)',
         },
         'secondary': {
           50: 'var(--secondary-50)',
           100: 'var(--secondary-100)',
           200: 'var(--secondary-200)',
           300: 'var(--secondary-300)',
           400: 'var(--secondary-400)',
           500: 'var(--secondary-500)',
           600: 'var(--secondary-600)',
           700: 'var(--secondary-700)',
           800: 'var(--secondary-800)',
           900: 'var(--secondary-900)',
           950: 'var(--secondary-950)',
         },
         'accent': {
           50: 'var(--accent-50)',
           100: 'var(--accent-100)',
           200: 'var(--accent-200)',
           300: 'var(--accent-300)',
           400: 'var(--accent-400)',
           500: 'var(--accent-500)',
           600: 'var(--accent-600)',
           700: 'var(--accent-700)',
           800: 'var(--accent-800)',
           900: 'var(--accent-900)',
           950: 'var(--accent-950)',
         },
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({addVariant}) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({addVariant}) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({addVariant}) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({matchComponents, theme}) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = {name, fullPath: path.join(iconsDir, dir, file)}
        })
      })
      matchComponents({
        "hero": ({name, fullPath}) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, {values})
    })
  ]
}
