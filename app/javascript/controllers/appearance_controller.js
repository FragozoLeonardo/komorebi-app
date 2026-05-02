import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.applyTheme()
        console.log("appearance controller connected")
    }

    toggle() {
        const html = document.documentElement
        const nextTheme = html.classList.contains("dark") ? "light" : "dark"

        this.setTheme(nextTheme)
        localStorage.setItem("theme", nextTheme)
        console.log("theme changed to:", nextTheme)
    }

    applyTheme() {
        const savedTheme = localStorage.getItem("theme")
        const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches

        if (savedTheme === "dark" || (!savedTheme && prefersDark)) {
            this.setTheme("dark")
        } else {
            this.setTheme("light")
        }
    }

    setTheme(theme) {
        if (theme === "dark") {
            document.documentElement.classList.add("dark")
        } else {
            document.documentElement.classList.remove("dark")
        }
    }
}