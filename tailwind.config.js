const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    "./public/index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
          sans: ['Nunito', ...defaultTheme.fontFamily.sans],
          serif: ['Merriweather', 'serif'],
      },
  },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
