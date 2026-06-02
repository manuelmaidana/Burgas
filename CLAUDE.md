# Burger Tour

Mobile-only Next.js app for 3 friends rating burgers across 4 restaurants in Buenos Aires.

## Mobile-only constraint

Max-width 430px, centered, dark theme only. No hover states, no desktop layouts. Bottom nav fixed with safe-area padding. All tap targets min 44px.

## Setup

```bash
npm install
npm run dev      # http://localhost:3000
npm run build
```

## Raters & Restaurants

**Raters:** Maida, Gena, Fran

**Restaurants (in order):**
1. Luisa's
2. Grasa
3. Fino
4. Guita

## Data Model

State stored in `localStorage` under key `burger-tour-state`. Managed via React context (`context/TourContext.tsx`).

```
TourState
  stops: Stop[]
  currentStopId: number

Stop
  id: 1-4
  name: Restaurant
  status: 'locked' | 'in-progress' | 'done'
  burgerNames: string[]
  ratings: { [friend]: FriendRatings }

FriendRatings
  burgers: BurgerRating[]   // one per burger
  fries: FriesRating

BurgerRating: { Pan, Punto de la carne, Salsas, Sabor, Personalidad, Originalidad, Calidad/precio }
FriesRating:  { Crocante, Condimentacion, Textura general, Personalidad, Originalidad, Calidad/precio }
```

All numeric ratings: 1.00-10.00.

## taste-skill integration

taste-skill (https://github.com/Leonxlnx/taste-skill) is a design-guidance framework.
Key principles applied: spring physics animations (framer-motion), hardware-accelerated transitions,
min-h-[100dvh] (not h-screen), staggered entry animations on results, isolated 'use client' components,
amber accent (#f59e0b) with off-black background (#1a1a1a), no generic card overuse.

Settings applied: DESIGN_VARIANCE=7 (mobile single-column, offset spacing), MOTION_INTENSITY=6 (spring physics), VISUAL_DENSITY=5 (daily app mode).

## Page / Component Structure

```
app/
  layout.tsx          Root layout: fonts, TourProvider, BottomNav
  page.tsx            Home: stop cards, progress dots
  stop/[id]/page.tsx  Stop: burger name setup -> friend rating tabs
  results/page.tsx    Results: animated rankings, category winners

components/
  BottomNav.tsx       Fixed bottom nav (Home / Current / Results)
  RatingControl.tsx   Stepper (+/-) with mini progress bar

context/
  TourContext.tsx     State, reducer, helpers (calcBurgerAvg, calcFriesAvg, calcStopOverall)
```

## Nav Pattern

Bottom nav: 3 items (Home, Current Stop, Results). Results locked until all 4 stops done. Each stop goes through: locked -> in-progress -> done.

## Key Decisions

- Ratings use 0.25 step increments for thumb-friendliness (displayed to 2 decimal places).
- `'use client'` on all interactive pages/components.
- State loaded from localStorage on mount, saved on every change.
- Stop screen uses two-step flow: (1) enter burger names, (2) rate per friend with burger/fries tabs.
- Framer Motion AnimatePresence for tab transitions, staggered motion.div reveals on home + results.
