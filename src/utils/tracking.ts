// Definición del tipo para el tracker
interface UmamiTracker {
  track: (eventName: string) => void;
}

// Helper con verificación de existencia
class UmamiAnalytics {
  private get tracker(): UmamiTracker | null {
    if (typeof window !== 'undefined' && window.umami) {
      return window.umami;
    }
    return null;
  }

  track(eventName: string): void {
    if (this.tracker) {
      this.tracker.track(eventName);
    } else {
      // Fallback silencioso en desarrollo
      if (import.meta.env.DEV) {
        console.log(`[Umami] Evento no enviado (tracker no disponible): ${eventName}`);
      }
    }
  }
}

// Exportar instancia única
export const umami = new UmamiAnalytics();

// Exportar tipos para usar en otros archivos
export type { UmamiTracker };