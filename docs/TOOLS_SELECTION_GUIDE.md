---
title: "Tools & Framework Selection Guide"
description: "How to choose the right tools and frameworks for Calm projects"
version: "1.0"
last_updated: "2025-11-01"
---

# Tools & Framework Selection Guide

Systematic approach to evaluating and selecting tools, libraries, and frameworks across calm-couples, calm-ai-project-manager, and qa-automation.

---

## Selection Criteria (The Framework)

When evaluating any tool, score it on these dimensions:

| Criterion | Weight | Scoring | Why It Matters |
|-----------|--------|---------|----------------|
| **Ecosystem Fit** | 30% | Does it fit with existing stack? | Consistency = lower token costs |
| **Team Knowledge** | 25% | Does team know it already? | Knowledge = faster implementation |
| **Learning Curve** | 20% | How hard to learn? | Hard curve = more tokens spent |
| **Maintenance Burden** | 15% | How much upkeep? | High burden = recurring token cost |
| **Token Cost** | 10% | How many tokens to implement? | Direct cost metric |

### Scoring System
- 🟢 Excellent (90-100): Strongly recommended
- 🟡 Good (70-89): Acceptable, consider trade-offs
- 🔴 Poor (< 70): Avoid unless critical

### Example Calculation
```
Criterion               Score   Weight   Total
Ecosystem Fit          95      30%      28.5
Team Knowledge         80      25%      20.0
Learning Curve         75      20%      15.0
Maintenance Burden     85      15%      12.8
Token Cost             70      10%      7.0
────────────────────────────────────
TOTAL SCORE                             83.3% 🟡 (Good)
```

---

## 1. State Management (React)

### Decision: Zustand vs Redux vs Jotai vs Context API?

#### Zustand
- **Ecosystem Fit**: 🟢 95% (used in calm-couples)
- **Team Knowledge**: 🟢 100% (well-documented here)
- **Learning Curve**: 🟢 90% (simple mental model)
- **Maintenance**: 🟢 95% (minimal boilerplate)
- **Token Cost**: 🟢 80% (3-5K per store setup)
- **TOTAL**: 93% 🟢 **USE THIS**

```typescript
// Zustand: Simple, effective, low cost
const useStore = create((set) => ({
  count: 0,
  increment: () => set(state => ({ count: state.count + 1 }))
}));
```

#### Redux
- **Ecosystem Fit**: 🟡 75% (overkill for Calm's needs)
- **Team Knowledge**: 🟡 70% (requires training)
- **Learning Curve**: 🔴 40% (very steep)
- **Maintenance**: 🟡 60% (lots of boilerplate)
- **Token Cost**: 🔴 30% (12-15K per setup)
- **TOTAL**: 55% 🔴 **AVOID** (use Zustand instead)

#### Context API
- **Ecosystem Fit**: 🟢 90% (built-in to React)
- **Team Knowledge**: 🟢 95% (everyone knows it)
- **Learning Curve**: 🟢 95% (very simple)
- **Maintenance**: 🟡 60% (performance issues with large state)
- **Token Cost**: 🟡 75% (5-8K, includes optimization)
- **TOTAL**: 83% 🟡 **OK FOR SMALL STATE**

**Recommendation**: Use **Zustand** for calm-couples, **Context** for small local state

---

## 2. Data Fetching (React)

### Decision: React Query vs SWR vs Apollo vs Fetch?

#### React Query
- **Ecosystem Fit**: 🟢 95% (recommended for calm-couples)
- **Team Knowledge**: 🟡 75% (needs learning)
- **Learning Curve**: 🟡 70% (moderate)
- **Maintenance**: 🟢 90% (powerful built-in helpers)
- **Token Cost**: 🟡 80% (5-8K per setup)
- **TOTAL**: 82% 🟡 **USE FOR COMPLEX DATA**

```typescript
// React Query: Cache management built-in
const { data, isLoading, error } = useQuery({
  queryKey: ['plants', gardenId],
  queryFn: () => api.getPlants(gardenId),
  staleTime: 5 * 60 * 1000, // 5 minutes
});
```

#### SWR
- **Ecosystem Fit**: 🟢 85% (lightweight alternative)
- **Team Knowledge**: 🟡 70% (less common)
- **Learning Curve**: 🟢 85% (simple API)
- **Maintenance**: 🟡 75% (good for simple cases)
- **Token Cost**: 🟡 75% (4-6K per setup)
- **TOTAL**: 78% 🟡 **OK ALTERNATIVE**

#### Fetch API + Manual Caching
- **Ecosystem Fit**: 🟢 95% (works everywhere)
- **Team Knowledge**: 🟢 100% (everyone knows fetch)
- **Learning Curve**: 🟢 95% (very simple)
- **Maintenance**: 🔴 40% (you manage caching)
- **Token Cost**: 🔴 35% (20-30K for robust implementation)
- **TOTAL**: 53% 🔴 **AVOID** (use React Query)

**Recommendation**: Use **React Query** for calm-couples, **fetch** for simple one-off calls

---

## 3. Styling (Web)

### Decision: Tailwind CSS vs CSS Modules vs Styled Components vs SASS?

#### Tailwind CSS
- **Ecosystem Fit**: 🟢 100% (used in calm-couples)
- **Team Knowledge**: 🟢 95% (well-known)
- **Learning Curve**: 🟡 75% (class names to memorize)
- **Maintenance**: 🟢 95% (no unused CSS)
- **Token Cost**: 🟢 90% (2-3K per component)
- **TOTAL**: 91% 🟢 **USE THIS**

```html
<!-- Tailwind: Fast, consistent styling -->
<div class="bg-white dark:bg-gray-900 text-black dark:text-white p-4 rounded">
  Content
</div>
```

#### CSS Modules
- **Ecosystem Fit**: 🟢 90% (built into most bundlers)
- **Team Knowledge**: 🟡 75% (less used recently)
- **Learning Curve**: 🟡 70% (scoping mental model)
- **Maintenance**: 🟡 70% (file per component)
- **Token Cost**: 🟡 75% (5-7K per component)
- **TOTAL**: 76% 🟡 **OK ALTERNATIVE**

#### Styled Components
- **Ecosystem Fit**: 🟡 75% (adds complexity)
- **Team Knowledge**: 🟡 60% (requires learning)
- **Learning Curve**: 🟡 65% (CSS-in-JS syntax)
- **Maintenance**: 🟡 65% (complex debugging)
- **Token Cost**: 🔴 40% (8-12K per component)
- **TOTAL**: 60% 🔴 **AVOID** (use Tailwind)

**Recommendation**: Use **Tailwind CSS** for all projects

---

## 4. Testing Framework (React)

### Decision: Jest + React Testing Library vs Vitest vs Cypress?

#### Jest + React Testing Library
- **Ecosystem Fit**: 🟢 100% (used in calm-couples)
- **Team Knowledge**: 🟢 95% (industry standard)
- **Learning Curve**: 🟡 75% (requires test thinking)
- **Maintenance**: 🟢 90% (stable, well-documented)
- **Token Cost**: 🟡 80% (3-5K per test suite)
- **TOTAL**: 88% 🟢 **USE THIS**

```typescript
// Jest + RTL: Industry standard
test('renders plant name', () => {
  render(<Plant name="Pothos" />);
  expect(screen.getByText('Pothos')).toBeInTheDocument();
});
```

#### Vitest
- **Ecosystem Fit**: 🟡 75% (newer, less adoption)
- **Team Knowledge**: 🔴 40% (few know it)
- **Learning Curve**: 🟢 85% (similar to Jest)
- **Maintenance**: 🟡 70% (still evolving)
- **Token Cost**: 🟡 75% (3-5K per suite)
- **TOTAL**: 69% 🔴 **SKIP FOR NOW** (use Jest)

#### Playwright (E2E)
- **Ecosystem Fit**: 🟢 95% (excellent for E2E)
- **Team Knowledge**: 🟡 70% (qa-automation uses this)
- **Learning Curve**: 🟡 75% (good docs)
- **Maintenance**: 🟡 75% (flaky tests possible)
- **Token Cost**: 🟡 80% (8-12K per E2E)
- **TOTAL**: 79% 🟡 **USE FOR E2E**

**Recommendation**: Use **Jest + RTL** for unit/integration, **Playwright** for E2E

---

## 5. Database (Calm Projects)

### Decision: Supabase vs Firebase vs MongoDB?

#### Supabase (PostgreSQL)
- **Ecosystem Fit**: 🟢 100% (used in calm-couples)
- **Team Knowledge**: 🟡 80% (SQL knowledge needed)
- **Learning Curve**: 🟡 70% (RLS policies complex)
- **Maintenance**: 🟢 95% (managed, reliable)
- **Token Cost**: 🟡 75% (5-8K for setup/optimization)
- **TOTAL**: 84% 🟢 **USE THIS**

```sql
-- Supabase: Powerful RLS policies
CREATE POLICY "Users can see own gardens"
ON gardens FOR SELECT
USING (auth.uid() = user_id);
```

#### Firebase Realtime Database
- **Ecosystem Fit**: 🟡 70% (different paradigm)
- **Team Knowledge**: 🔴 40% (NoSQL, unfamiliar)
- **Learning Curve**: 🟡 75% (different mental model)
- **Maintenance**: 🟢 95% (fully managed)
- **Token Cost**: 🟡 80% (5-8K for setup)
- **TOTAL**: 72% 🟡 **OK ALTERNATIVE** (not recommended)

#### MongoDB
- **Ecosystem Fit**: 🔴 30% (overkill for relational data)
- **Team Knowledge**: 🟡 60% (NoSQL learning curve)
- **Learning Curve**: 🟡 70% (schema flexibility = complexity)
- **Maintenance**: 🟡 60% (need to manage)
- **Token Cost**: 🔴 40% (10-15K for proper setup)
- **TOTAL**: 52% 🔴 **AVOID** (Supabase is better)

**Recommendation**: Use **Supabase** for all projects

---

## 6. API Framework (Node)

### Decision: Express vs Fastify vs Nest.js?

#### Express
- **Ecosystem Fit**: 🟢 100% (used in calm-ai-pm)
- **Team Knowledge**: 🟢 95% (most common)
- **Learning Curve**: 🟢 95% (simple)
- **Maintenance**: 🟡 70% (need middleware knowledge)
- **Token Cost**: 🟢 90% (3-5K per endpoint)
- **TOTAL**: 90% 🟢 **USE THIS**

```javascript
// Express: Simple, straightforward
app.post('/api/plants', async (req, res) => {
  const plant = await db.plants.create(req.body);
  res.json(plant);
});
```

#### Fastify
- **Ecosystem Fit**: 🟡 75% (newer, smaller ecosystem)
- **Team Knowledge**: 🔴 40% (less familiar)
- **Learning Curve**: 🟡 75% (similar to Express)
- **Maintenance**: 🟡 70% (good docs)
- **Token Cost**: 🟡 75% (4-6K per endpoint)
- **TOTAL**: 67% 🔴 **SKIP** (use Express)

#### Nest.js
- **Ecosystem Fit**: 🟡 65% (opinionated architecture)
- **Team Knowledge**: 🔴 35% (TypeScript OOP learning)
- **Learning Curve**: 🔴 50% (steep, lots of concepts)
- **Maintenance**: 🟡 70% (good for large teams)
- **Token Cost**: 🔴 40% (10-15K per endpoint)
- **TOTAL**: 52% 🔴 **AVOID** (overkill for Calm)

**Recommendation**: Use **Express** for all Node projects

---

## 7. Authentication

### Decision: Supabase Auth vs Auth0 vs Firebase Auth?

#### Supabase Auth
- **Ecosystem Fit**: 🟢 100% (integrated with DB)
- **Team Knowledge**: 🟡 75% (JWT-based)
- **Learning Curve**: 🟡 75% (good docs)
- **Maintenance**: 🟢 95% (managed)
- **Token Cost**: 🟢 90% (2-3K integration)
- **TOTAL**: 91% 🟢 **USE THIS**

#### Auth0
- **Ecosystem Fit**: 🟢 90% (works anywhere)
- **Team Knowledge**: 🟡 70% (different auth paradigm)
- **Learning Curve**: 🟡 75% (good docs)
- **Maintenance**: 🟢 95% (fully managed)
- **Token Cost**: 🟡 75% (3-5K integration)
- **TOTAL**: 81% 🟡 **OK ALTERNATIVE** (costs $$$)

#### Firebase Auth
- **Ecosystem Fit**: 🟡 80% (Firebase-specific)
- **Team Knowledge**: 🟡 70% (different ecosystem)
- **Learning Curve**: 🟢 85% (simple)
- **Maintenance**: 🟢 95% (managed)
- **Token Cost**: 🟡 80% (2-4K integration)
- **TOTAL**: 82% 🟡 **OK IF USING FIREBASE**

**Recommendation**: Use **Supabase Auth** (integrated, lower cost)

---

## 8. Payment Processing

### Decision: Stripe vs Square vs Paddle?

#### Stripe
- **Ecosystem Fit**: 🟢 100% (industry standard)
- **Team Knowledge**: 🟢 95% (well-known)
- **Learning Curve**: 🟡 75% (webhooks complex)
- **Maintenance**: 🟡 75% (webhook failures possible)
- **Token Cost**: 🟡 80% (5-8K for setup/webhooks)
- **TOTAL**: 85% 🟢 **USE THIS**

#### Square
- **Ecosystem Fit**: 🟡 70% (US-focused)
- **Team Knowledge**: 🟡 60% (less familiar)
- **Learning Curve**: 🟡 75% (similar to Stripe)
- **Maintenance**: 🟡 75% (good support)
- **Token Cost**: 🟡 80% (5-8K for setup)
- **TOTAL**: 72% 🟡 **OK ALTERNATIVE**

#### Paddle
- **Ecosystem Fit**: 🟡 70% (SaaS-focused)
- **Team Knowledge**: 🔴 40% (less known)
- **Learning Curve**: 🟢 85% (simple API)
- **Maintenance**: 🟡 70% (smaller support)
- **Token Cost**: 🟡 80% (5-8K for setup)
- **TOTAL**: 69% 🔴 **AVOID** (Stripe more mature)

**Recommendation**: Use **Stripe** for all payment processing

---

## 9. Monitoring & Analytics

### Decision: Sentry vs LogRocket vs Custom Logger?

#### Custom Logger (calm-ai-pm approach)
- **Ecosystem Fit**: 🟢 100% (no external deps)
- **Team Knowledge**: 🟢 95% (full control)
- **Learning Curve**: 🟢 95% (simple)
- **Maintenance**: 🟡 70% (you maintain it)
- **Token Cost**: 🟡 75% (3-5K for robust logger)
- **TOTAL**: 87% 🟢 **USE FOR LOGS**

```javascript
// Custom logger: Full control, low cost
logger.debug('Controller', 'message', data);
logger.error('Controller', 'error', { err, context });
```

#### Sentry
- **Ecosystem Fit**: 🟢 90% (works anywhere)
- **Team Knowledge**: 🟡 70% (needs learning)
- **Learning Curve**: 🟡 75% (good docs)
- **Maintenance**: 🟢 95% (managed)
- **Token Cost**: 🟡 75% (2-3K integration)
- **TOTAL**: 81% 🟡 **USE FOR ERROR TRACKING**

#### LogRocket
- **Ecosystem Fit**: 🟡 75% (session replay)
- **Team Knowledge**: 🔴 40% (specialized tool)
- **Learning Curve**: 🟡 75% (good integration)
- **Maintenance**: 🟢 95% (managed)
- **Token Cost**: 🟡 80% (2-3K integration)
- **TOTAL**: 73% 🟡 **OK FOR DEBUGGING**

**Recommendation**: Use **Custom Logger** for logs + **Sentry** for error tracking

---

## 10. Deployment

### Decision: Vercel vs Railway vs Render vs AWS?

#### Vercel
- **Ecosystem Fit**: 🟢 100% (Next.js native)
- **Team Knowledge**: 🟢 95% (simple)
- **Learning Curve**: 🟢 95% (git-based deploys)
- **Maintenance**: 🟢 95% (zero DevOps)
- **Token Cost**: 🟢 95% (no config needed)
- **TOTAL**: 96% 🟢 **USE FOR NEXT.JS**

#### Railway
- **Ecosystem Fit**: 🟡 85% (any framework)
- **Team Knowledge**: 🟡 75% (minimal DevOps)
- **Learning Curve**: 🟡 80% (good UI)
- **Maintenance**: 🟢 90% (mostly managed)
- **Token Cost**: 🟡 80% (1-2K setup)
- **TOTAL**: 82% 🟡 **GOOD ALTERNATIVE**

#### AWS
- **Ecosystem Fit**: 🟡 70% (complex setup)
- **Team Knowledge**: 🔴 30% (requires DevOps)
- **Learning Curve**: 🔴 40% (steep)
- **Maintenance**: 🔴 50% (you manage everything)
- **Token Cost**: 🔴 35% (20-40K for setup)
- **TOTAL**: 45% 🔴 **AVOID** (use Vercel/Railway)

**Recommendation**: Use **Vercel** for frontend, **Railway** for backend

---

## Selection Checklist

When evaluating any new tool:

- [ ] Does it fit existing tech stack?
- [ ] Does team already know it?
- [ ] What's the learning curve?
- [ ] How much ongoing maintenance?
- [ ] What's the token cost to implement?
- [ ] Calculate total score using framework
- [ ] Check standards documentation
- [ ] Compare to existing alternatives
- [ ] Document the decision
- [ ] Review after 1 month of use

---

## Current Calm Standards

**Frontend** (calm-couples, qa-automation frontend):
- Framework: React 19
- State: Zustand
- Data: React Query
- Styling: Tailwind CSS
- Testing: Jest + React Testing Library
- Deployment: Vercel

**Backend** (calm-ai-project-manager):
- Framework: Express
- Database: Supabase (PostgreSQL)
- Auth: Supabase Auth
- Payments: Stripe
- Logging: Custom logger + Sentry
- Deployment: Railway

**E2E Testing** (qa-automation):
- Framework: Playwright
- Debugging: Local browser + Device when needed
- Cost tracking: token-tracker.sh

---

## Adding New Tools

To evaluate a new tool:

1. **Get the criteria sheet** (10 dimensions above)
2. **Score it honestly** (don't inflame existing preferences)
3. **Compare to current tool** (what's the delta?)
4. **Calculate total score** (weighted average)
5. **If score > 85%**: Consider switching
6. **If score 70-85%**: Document alternative
7. **If score < 70%**: Keep current tool
8. **Document decision** in this guide

---

## See Also

- [DECISION_TREES.md](DECISION_TREES.md) - How to make tech decisions
- [TOKEN_EFFICIENCY.md](../docs/cost-optimization/TOKEN_EFFICIENCY.md) - Cost optimization
- Project READMEs - Tool usage in practice
- AGENTS.md files - Tool patterns per project

---

**Version**: 1.0 | **Last Updated**: 2025-11-01 | **Review Cadence**: Quarterly
