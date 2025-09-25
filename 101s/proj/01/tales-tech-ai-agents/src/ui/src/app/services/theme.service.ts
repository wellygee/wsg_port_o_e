import { Injectable, signal, WritableSignal, effect, PLATFORM_ID, Inject } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
@Injectable({
  providedIn: 'root'
})
export class ThemeService {
  private readonly THEME_KEY = 'ui-theme-preference';
  private readonly DARK_CLASS = 'dark';
  private HTML_ELEMENT: HTMLElement | null = null;
  private readonly isBrowser: boolean;

  // Theme state managed through signals
  private _isDarkMode: WritableSignal<boolean>;

  constructor(@Inject(PLATFORM_ID) private platformId: Object) {
    this.isBrowser = isPlatformBrowser(this.platformId);
    if (this.isBrowser) {
      this.HTML_ELEMENT = document.documentElement;
      // Initialize with stored preference or use light as default
      const storedTheme = localStorage.getItem(this.THEME_KEY);
      // Use stored preference if available, otherwise default to light mode
      const initialTheme = storedTheme ? storedTheme === 'dark' : false; // Default to light mode
      this._isDarkMode = signal(initialTheme);
      // Setup effect to update theme when signal changes
      effect(() => {
        this.applyTheme(this._isDarkMode());
      });

      // Apply theme on initialization
      this.applyTheme(initialTheme);
    } else {
      // Default theme signal for server-side rendering - now defaulting to light
      this._isDarkMode = signal(false);
    }
  }

  // Public getter for theme state
  get isDarkMode() {
    return this._isDarkMode.asReadonly();
  }

  // Public method to toggle theme
  toggleTheme(): void {
    if (!this.isBrowser) return;

    const newTheme = !this._isDarkMode();
    this._isDarkMode.set(newTheme);
    localStorage.setItem(this.THEME_KEY, newTheme ? 'dark' : 'light');
  }

  // Public method to explicitly set theme
  setTheme(dark: boolean): void {
    if (!this.isBrowser) return;

    this._isDarkMode.set(dark);
    localStorage.setItem(this.THEME_KEY, dark ? 'dark' : 'light');
  }

  // Method to apply theme to the HTML element
  private applyTheme(isDark: boolean): void {
    if (!this.isBrowser || !this.HTML_ELEMENT) return;

    if (isDark) {
      this.HTML_ELEMENT.classList.add(this.DARK_CLASS);
    } else {
      this.HTML_ELEMENT.classList.remove(this.DARK_CLASS);
    }
  }
}
