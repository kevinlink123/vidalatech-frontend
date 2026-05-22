// src/types/umami.d.ts
interface UmamiTracker {
  track: (eventName: string, eventData?: Record<string, unknown>) => void;
}

// Extender la interfaz Window global
declare global {
  interface Window {
    umami?: UmamiTracker;
  }
}

// Necesario para que TypeScript trate esto como un módulo
export {};