# The Isometric Space of the Mental Stage  
_intro to the Teatro visual platform_

> You do not have to write scripts to speak Teatro.  
> You move, you place, you colour, you time.  
> The “language” is simply the shadow your choices cast.

---

## 0. Teatro is a Space, Not a Scripting Language

Teatro starts **visually**, not verbally.

What we give you first is not a prompt syntax or a DSL reference.  
What we give you is:

- an **isometric stage** (the mental stage made visible),  
- a **screenplay track** (dialogue and action over time),  
- a **score track** (tempo, energy, light, dynamics),  
- and a **shared room** for humans and LLMs to work in.

When you drag a character, sketch an energy arc, or darken the light,  
Teatro quietly writes a DSL _underneath_ that move.

You never have to see this DSL.  
You don’t need to type it.  
You don’t even need to know it exists.

It is there for **structure**, not for **performance**.

- The **human** works in pictures, gestures, and words.  
- The **AI** works in graphs, cues, and constraints.  
- Teatro is the bridge – a _visual grammar of thought_ with an internal notation.

This chapter is about that visual grammar:  
**the isometric space of the mental stage** and its companion views  
(screenplay and score).

---

## 1. The Mental Stage: Where You Already Work

Before there is a rehearsal room, there is a room in your head.

Directors run blocking in their mind.  
Actors rehearse monologues in invisible light.  
Playwrights let characters collide in an interior theatre where no set has been built yet.

This is the **mental stage**:

- It has **actors** (characters, forces, moods).  
- It has **positions** (close, far, left, right, upstage, downstage).  
- It has **focus** (someone is “in the light”, someone else fades).  
- It has **tension lines** (who pulls on whom, who avoids whom).  
- It has **tempo** (beats, pauses, accelerations).

You are already staging your work mentally.  
Teatro’s promise is simple:

> _Let’s give that inner stage a surface._  
> So that you, your collaborators, and your LLMs can all see the same thing.

---

## 2. Why Isometric Space?

We needed a space that feels like **a real stage** but behaves like **paper**.

Isometric space does exactly that:

- It **looks** like 3D:  
  you see a floor, depth, upstage / downstage, left / right.
- It **acts** like 2D:  
  distances are simple, directions are stable, nothing shrinks in the distance.

That means:

- Moving a character “upstage” is literally moving them “back” on the plane.  
- Moving them “downstage” is bringing them “forward”.  
- Stage Left / Stage Right read immediately in the drawing.  
- Emotional distance can be seen in physical distance.

No cameras. No vanishing points. No 3D engine.  
Just a **diamond-shaped floor** and some very smart dots.

You can think of it as a **chessboard for drama**:

- each square is a possible choice of presence, absence, power, vulnerability.  
- each move has meaning, before a single line is spoken.

---

## 3. The Isometric Mental Stage in Practice

Imagine a transparent diamond on your screen:  
front edge = **downstage**, back edge = **upstage**.

You drop two tokens onto it:

- A = blue circle (the one who wants to talk),  
- B = orange circle (the one who avoids).

You now play with a few simple gestures:

1. **Place them far apart** on opposite downstage corners.  
   - The scene reads as **confrontational** or **strained**.  

2. **Bring A closer to B**, a diagonal step toward upstage-right.  
   - Visual meaning: A is **leaning in**.

3. **Let B drift back and right**, toward the back corner.  
   - Visual meaning: B is **avoiding**.

4. Draw a **line** between A and B:  
   - thick & bright = a strong line of communication,  
   - faded & dashed = attempts that don’t quite connect,  
   - broken = silence, refusal, or interruption.

Now add a thin wash of **light**:

- warm & concentrated → intimacy, confession, safety.  
- cold & broad → distance, analysis, vigilance.

None of this required a word of DSL.  
But internally, Teatro has already understood:

- there are two characters,  
- they have positions and a changing distance,  
- one is structurally avoiding the other,  
- the connection between them strengthens then collapses.

This is your **mental stage**, tracked explicitly and shareably.

---

## 4. Three Views of Teatro

Teatro is not one interface.  
It’s the same scene, seen through three different lenses:

1. **Isometric Stage View**  
2. **Screenplay View**  
3. **Score View**

The internal DSL is just what keeps them in sync.

### 4.1 Isometric Stage View – “Where”

- Shows **who is where, when**.  
- Uses an isometric floor, character markers, lines, icons.  
- Lets you see **spatial relationships** and **energy flows**.

You think in questions like:

- Who is far / near?  
- Who is in the foreground?  
- Where do we feel tension?  
- Who is turned toward or away from whom?

You manipulate:

- positions,  
- orientations,  
- lines of connection,  
- isosurfaces of light or attention.

### 4.2 Screenplay View – “What”

- Horizontal timeline with text: dialogue and action.  
- Beats are vertical slits in the timeline.  
- Each beat links down to the stage view:  
  click a line, see the stage snapshot at that moment.

You think in questions like:

- What is said in this beat?  
- What changes between the previous line and this one?  
- Where does this line land physically?

You manipulate:

- wording,  
- who speaks when,  
- parentheticals (subtext, tone),  
- beat boundaries.

### 4.3 Score View – “How”

- Abstract view of **tempo, intensity, light, sound, dynamics**.  
- Looks more like a musical staff or a graph than a stage.  
- Lines might represent:
  - emotional intensity of each character,  
  - scene tempo,  
  - light levels,  
  - sound presence.

You think in questions like:

- Where does the scene crescendo?  
- Where does the energy drop?  
- Where is the longest silence?

You manipulate:

- crescendos and decrescendos,  
- pauses and accelerations,  
- shifts in light or sound per beat,  
- global or local tempo.

---

## 5. The DSL as Shadow, Not Surface

Under these three views, Teatro keeps a **single structured representation** of the scene.

That representation is what we call the “Teatro DSL”.

You don’t **write** it.  
You **cause** it.

When you:

- drag A closer to B,  
- mark a beat boundary in the screenplay,  
- draw an energy swell in the score,

Teatro’s internal state changes, and the DSL updates to match.

Think of it like:

- MIDI for your staging,  
- a score behind the score,  
- a JSON for your drama.

Why is it useful, if you never see it?

- It gives **LLMs a stable API** to your scene.  
- It allows **automation** (generate variations, check continuity, suggest moves).  
- It allows **export** (to other tools, formats, engines).  
- It allows **replay and analysis** (baseline vs. variation, pattern detection).

For power users, we may eventually show read-only fragments of this DSL  
as “X-ray” views.  
But the core design principle is:

> **Your primary language is spatial, verbal, musical.  
> Not syntactic.**

---

## 6. How Teatro Learns from Your Hands

Here’s how a typical interaction cycle looks:

1. **You act on the visual world.**  
   - Drag a character on the isometric stage.  
   - Rewrite a line in the screenplay.  
   - Stretch an energy curve in the score.

2. **Teatro infers semantics.**  
   - “A approached B by ~40% of stage depth.”  
   - “The scene tempo slowed down in Beat 3.”  
   - “The light cooled and narrowed during B’s monologue.”

3. **Teatro updates internal structure (DSL).**  
   - Character positions, distances, and relationships.  
   - Beat boundaries and dramatic functions.  
   - Lighting, tempo, and sound cues over time.

4. **LLMs reason on that structure.**  
   - Dramaturg AI sees an avoidance pattern emerging.  
   - Director AI suggests an alternative spacing.  
   - Composer AI suggests where to lay in sound.

5. **You see visual suggestions, not code.**  
   - The system might ghost-in a proposed alternative blocking.  
   - Or highlight a portion of the score that could be rebalanced.  
   - Or annotate a line: “What if B moved upstage here?”.

You remain the conductor.  
The DSL remains backstage, with the stage manager and assistant AIs.

---

## 7. Shared Reasoning: Director, Actor, LLM

The isometric mental stage is especially powerful in **group work**.

Consider a room (real or virtual) with:

- a **human director**,  
- a **human actor**,  
- a **Teatro-aware LLM** (as dramaturg, stage manager, or “ideal audience”).

All three look at the **same three views**:

- Stage: where they are.  
- Screenplay: what is said.  
- Score: how it feels over time.

### Example: Avoiding Communication

Scene: A wants to talk; B is avoiding.

1. The director drags A one step forward, toward B.  
2. The actor says, “Let me try making that step tentative,” and slows the move.  
3. The LLM, watching the scene state, observes:
   - A moved closer,  
   - B did not,  
   - the connection line brightened then faded.

The LLM can now say in natural language:

> “We have a pattern: A repeatedly closes distance,  
> B repeatedly retreats.  
> Would you like to mark this as a _‘pursuit / avoidance’_ motif  
> and see where else it shows up?”

This is **decoding**, not scripting.

- The human sees the motif in the isometric pattern.  
- The AI sees the motif in the internal DSL.  
- Both talk about the same thing.

You get **shared insight** without anyone needing to think in opcodes.

---

## 8. UX Sketches: How the Views Interlock

What follows are textual sketches of the UX.  
Treat them as conceptual wireframes, not pixel-perfect designs.

### 8.1 Stage View (Isometric Mental Stage)

- Centered diamond representing the stage.  
- Tokens for characters (colours, initials).  
- Lines between characters for tension / communication.  
- Soft overlays for light / mood.  
- Optional “sound ribbons” that cross the floor for music or sound effects.

**Interactions:**

- Drag a character → move them in space.  
- Drag a line endpoint → change who is connected.  
- Pinch / scroll → zoom in/out on part of the stage.  
- Hover/tap a beat marker → see where everyone stands at that beat.

**Feedback:**

- Small textual hints like “A approaches B” or “Distance increases” appear.  
- Subtle animations show easing of moves, breathing of light.

### 8.2 Screenplay View (Script Track)

- A familiar script layout: character names, dialogue, action lines.  
- Beat markers in the margins (▶ Beat 1, ▶ Beat 2, …).  
- Each beat marker is linked to stage & score snapshots.

**Interactions:**

- Edit text normally (Teatro does not interfere with your writing flow).  
- Click a beat marker → stage view jumps to that beat’s positions.  
- Split a beat → new beat marker appears, stage view interpolates positions if needed.  
- Tag a line (“this is where she decides to leave”) → score view shows an emotional spike.

**Feedback:**

- Non-intrusive annotations like:
  - “This beat currently has high spatial distance but low verbal conflict.”  
  - “You have four beats in a row with static staging — want suggestions?”

### 8.3 Score View (Energy & Cues)

- Several horizontal lanes:
  - one per character (emotional intensity / focus),  
  - one for overall tempo,  
  - one for light,  
  - one for sound.

**Interactions:**

- Drag a curve up → intensify.  
- Drag a curve down → soften.  
- Draw a plateau → hold a mood.  
- Draw a spike → accent.

**Feedback:**

- Stage view gently exaggerates the spatial / lighting effects to match.  
- Screenplay view might highlight lines that now sit on peaks or valleys.

### 8.4 Cross-links

- Selecting a character in Stage highlights their lane in Score  
  and their lines in Screenplay.  
- Selecting a beat in Screenplay outlines the floor polygon in Stage  
  and shades the relevant region in Score.  
- Making a change in one view propagates into the others.

Underneath, the DSL is updated.  
On top, you stay in your preferred mode:

- **some people live in the stage**,  
- **some in the text**,  
- **some in the waveform**.

Teatro respects all of them.

---

## 9. Screenplay View & Classic Score: Other Faces of the Same Model

You mentioned two other “views of the possible visualizations”:

- a **screenplay view**,  
- and a **classic score**.

In this architecture:

- The **screenplay view** is your narrative backbone.  
- The **classic score** is your time/energy backbone.  
- The **isometric stage** is your spatial backbone.

All three are just **faces of the same underlying scene**.

The DSL binds them, but you don’t have to.

You write your play, you sculpt your stage, you draw your energy.  
Teatro keeps them coherent:

- no line without a spatial context,  
- no movement without temporal context,  
- no dynamic swell without narrative context.

This coherence is what allows LLMs to act not as autocomplete engines  
but as **collaborators** who see what you see.

---

## 10. How to Read This Field Guide

As you move through the rest of the Teatro Field Guide,  
keep this stack in mind:

1. **Isometric Stage** – mental geometry of the scene.  
2. **Screenplay** – textual logic of the scene.  
3. **Score** – temporal and energetic logic of the scene.  
4. **DSL (internal)** – structural binding of all three.

When we show code fragments, treat them as **X-rays** of what your hands, eyes, and ears are already doing in the interface.

You are not the programmer here.  
You are the director, the playwright, the performer.

Teatro’s job is to make your **inner stage sharable**,  
and to give LLMs a way to understand it without you ever having to leave  
the world of **pictures, words, and music**.

Welcome to the isometric space of the mental stage.  
From here on, every move you imagine can become something the system sees,  
and every suggestion the system makes can be grounded in a stage picture  
you recognize as your own.

That is the core promise:  
**no more opaque AI magic** — only visible, playable, discussable choices  
on a shared stage.

Curtain up.

