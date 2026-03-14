// ============================================================
//  (UNOFFICIAL) UCL PhD Thesis Template
// Author: chpxu
// ============================================================
//
// ============================================================
//  Theorem environments
// ============================================================
#import "@preview/ctheorems:1.1.3": *
#show: thmrules

#let theorem = thmbox(
  "theorem", // identifier
  "Theorem", // head
  fill: rgb("#aaf1fa"),
)
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong,
)
#let definition = thmbox(
  "definition",
  "Definition",
  inset: (left: 12pt, top: 8pt, right: 8pt, bottom: 8pt),
  fill: rgb("#cffcff"),
)
#let lemma = thmbox(
  "theorem", // identifier - same as that of theorem
  "Lemma", // head
  fill: rgb("#efe6ff"),
)
#let proposition = thmbox(
  "theorem", // identifier - same as that of theorem
  "Proposition", // head
  fill: rgb("#dd99eb"),
)
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

// ============================================================
//  EXTRA PACKAGES AND THEIR CONFIGURATION
// - They are separated by headers like these
// - Imported packages that have default configuration all go in the final block
// ============================================================
#import "@preview/algorithmic:1.0.7"
#import algorithmic: algorithm, algorithm-figure, style-algorithm
#show: style-algorithm.with(
  breakable: true,
  caption-style: emph,
  placement: none,
  scope: "column",
)
#let algo-vstroke = 0.5pt + luma(200)
// ============================================================
//  Unconfigured packages
//
// ============================================================
#import "@preview/physica:0.9.8": *
#import "@preview/fancy-units:0.1.1": add-macros, fancy-units-configure, num, qty, unit
#import "@preview/cetz:0.4.2"
#import "@preview/mannot:0.3.2": *
#import "@preview/inknertia:0.1.0": *
#import "@preview/wordometer:0.1.5": total-words, word-count
// ============================================================
//  CUSTOM COMMANDS/FUNCTIONS
// ============================================================

// ──────── Unnumbered Typst Equation ────────
// Usage: #nonum($math expression$)
#let nonum(eq) = math.equation(block: true, numbering: none, eq)
// ──────── Shorthand references like in LaTeX ────────
// Usage: func("<ref or citation>")
// Note: no auto-complete
#let eqref(id) = [Eq.~(#ref(label(id), supplement: none))]
#let refshort(id) = [Ref.~#cite(label(id))]
#let figref(id) = [Fig.~(#ref(label(id), supplement: none))]


#let ucl-thesis(
  // ── Required metadata ──────────────────────────────────────
  title: "Thesis Title",
  author: "Author Name",
  department: "Department of X",
  faculty: "Faculty of Y",
  degree: "Doctor of Philosophy",
  year: "2026",
  // ── Optional metadata ──────────────────────────────────────
  subtitle: none,
  supervisors: (),
  wordcount: none,
  // ── Front-matter sections  ──────────────
  declaration: none,
  abstract: none,
  impact-statement: none,
  acknowledgements: none,
  dedication: none,
  // ── Layout options ─────────────────────────────────────────
  line-spacing: 1.5,
  font-size: 12pt,
  font-body: "New Computer Modern",
  font-heading: "New Computer Modern",
  //  Note to the user
  // The UCL guidelines suggest that ("should") the lines should be 1.5x or 2x spaced. Uncomment (remove the corresponding "%" before the line) to use (line 48 for 1.5x spacing, 49 for 2x spacing).
  // The UCL guidelines enforce that ("must be") margins at the binding edge must be not be less than 40 mm (1.5 inches) and other margins not less than 20 mm (.75 inches). In this document, both left and right margins are set to 40mm, and top and bottom to 20mm. If the user wants just the binding edge to be 40mm, and the other to be 20mm (or more), they should change the "right" parameter of the geometry package options (line 4).
  //% The UCL guidelines suggest that ("recommend") the minimum font size is 12. This can be changed in the \documentclass [options] selection (line 3). In this document, the default to 12pt.
  //% The UCL guidelines suggest that ("recommend") the font is either Arial or Helvettica. I have included ways of using those fonts in the document above, uncomment to use. (line 45 for Helvettica, 46 for Arial).
  binding-margin: 40mm,
  outer-margin: 40mm,
  // ── Feature flags ──────────────────────────────────────────
  show-list-of-figures: true,
  show-list-of-tables: true,
  show-list-of-algorithms: true,
  show-list-of-notation: true,
  // ── The body of the thesis ─────────────────────────────────
  body,
) = {
  set math.equation(numbering: "(1.1)")
  // ── Page geometry ──────────────────────────────────────────
  set page(
    paper: "a4",
    margin: (
      left: binding-margin,
      right: outer-margin,
      top: 25mm,
      bottom: 25mm,
    ),
    // overridden per section below
    numbering: none,
  )

  // ── Typography ─────────────────────────────────────────────
  set text(
    font: font-body,
    size: font-size,
    lang: "en",
    region: "GB",
  )

  set par(
    leading: line-spacing * 0.65em,
    spacing: 1.2em,
    justify: true,
    first-line-indent: 1.0em,
  )

  // ── Headings ───────────────────────────────────────────────
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    block({
      if it.numbering != none {
        text(
          font: font-heading,
          size: font-size * 2.0,
          weight: "bold",
          it.supplement + " " + counter(heading).display(it.numbering) + "\n",
        )
      }
      text(font: font-heading, size: font-size * 2.0, weight: "bold", it.body)
    })
    v(1.5em)
  }

  show heading.where(level: 2): it => {
    v(1em)
    block(text(
      font: font-heading,
      size: font-size * 1.25,
      weight: "bold",
      if it.numbering != none { counter(heading).display("1.1") + "  " } + [] + it.body,
    ))
    v(0.5em)
  }

  show heading.where(level: 3): it => {
    v(0.8em)
    block(text(
      font: font-heading,
      size: font-size * 1.1,
      weight: "bold",
      if it.numbering != none { counter(heading).display("1.1.1") + "  " } + [] + it.body,
    ))
    v(0.3em)
  }

  // ── Figures & tables ───────────────────────────────────────
  // show figure.caption: it => {
  //   set text(size: font-size * 0.9)
  //   align(left, it)
  // }
  show table.cell.where(y: 0): strong
  set table(
    stroke: (x, y) => (
      left: { 0pt },
      right: { 0pt },
      top: if y < 1 { stroke(1pt) } else if y == 1 { none } else { 0pt },
      bottom: if y < 1 { stroke(.5pt) } else { stroke(1pt) },
    ),
    align: (x, y) => (
      if x > 0 { center } else { left }
    ),
  )
  // Change this to bottom if you prefer bottpm captions for tables
  show figure.where(kind: table): set figure.caption(position: top)

  //set figure(gap: 0.8em)

  // ── Math ──────────────────────────────────────────────
  set math.equation(numbering: "(1.1)")
  set math.mat(row-gap: 0.5em, column-gap: 1em)
  show math.equation.where(block: true): it => {
    set align(center)
    it
    v(0.3em)
  }

  // ── Footnotes ──────────────────────────────────────────────
  set footnote.entry(separator: line(length: 30%, stroke: 0.5pt))

  // ── Block quotes ───────────────────────────────────────────
  show quote.where(block: true): it => {
    pad(left: 2em, right: 1em, text(style: "italic", it.body))
  }
  // ── Citations, Links and References ───────────────────────────────────────────────
  // Source: https://github.com/typst/typst/discussions/4143
  show cite: it => {
    show regex("\d+"): set text(fill: blue)
    it
  }

  show ref: it => {
    if it.element == none {
      // This is a citation, which is handled above.
      return it
    }
    // Only color the number, not the supplement.
    show regex("[\d.]+"): set text(fill: blue)
    it
  }
  // ── Bibliography ───────────────────────────────────────────────
  // Source: https://forum.typst.app/t/how-can-i-configure-linking-and-color-in-my-bibliography/1672/6
  show bibliography: it => {
    // this show rule transforms the original link
    // into plain text, so we can match it with a regex
    show link: it => {
      if it.body.text == it.dest {
        // link before processing
        it.body
      } else {
        it
      }
    }
    // this show rule matches the magic prefixes and suffixes ...
    let link-magic = regex("<<<(.*)\|\|\|\s*(.*)>>>")
    show link-magic: it => {
      // ... and renders it as a custom link
      set text(fill: blue)
      link(..it.text.matches(link-magic).first().captures)
    }
    it
  }
  // ────────────────────────────────────────────────────────────
  //  TITLE PAGE
  // ────────────────────────────────────────────────────────────
  page(margin: (left: binding-margin, right: outer-margin, top: 30mm, bottom: 25mm), {
    set align(center)

    image("title/logo.png")
    // Title
    line(
      length: 100%,
      stroke: 2pt,
    )
    text(font: font-heading, size: font-size * 1.8, weight: "bold", title)
    line(
      length: 100%,
      stroke: 2pt,
    )
    if subtitle != none {
      text(font: font-heading, size: font-size * 1.3, style: "italic", subtitle)
    }

    v(1.0em)
    text(size: font-size * 1.6, weight: "bold", upper(author))
    linebreak()
    text(size: font-size * 1.25, upper("UNIVERSITY COLLEGE LONDON"))
    // linebreak()
    if faculty != none {
      linebreak()
      text(size: font-size, faculty)
    }
    linebreak()

    text(size: font-size, department)
    v(0.5em)
    text(
      size: font-size,
      "Submitted to University College London (UCL) in partial fulfilment of the requirements for the degree of",
    )
    linebreak()
    text(font: font-heading, size: font-size * 1.2, weight: "bold", degree)

    v(1.5em)

    // text(size: font-size, year)

    if supervisors.len() > 0 {
      text(
        size: font-size,
        weight: "semibold",
        "Supervisor" + if supervisors.len() > 1 { "s" } else { "" } + ":",
      )
      linebreak()
      for s in supervisors {
        text(size: font-size, s)
        linebreak()
      }
    }
    if wordcount != none {
      v(1em)
      par(
        first-line-indent: 0em,
        text(weight: "bold", upper("word count: ") + wordcount),
      )
    }
  })

  // ────────────────────────────────────────────────────────────
  //  DECLARATION OF AUTHORSHIP
  // ────────────────────────────────────────────────────────────
  {
    set page(numbering: "i")
    counter(page).update(1)

    page({
      heading(level: 1, numbering: none, "Declaration")
      par(
        first-line-indent: 0em,
        "I, "
          + author
          + ", confirm that the work presented in this thesis is my own. "
          + "Where information has been derived from other sources, I confirm that this has "
          + "been indicated in the thesis.",
      )
      if declaration != none {
        v(1em)
        declaration
      }

      v(3em)
      text("Signature: ")
      v(0.5em)
      line(length: 45%)
      v(1.5em)
      text("Date: ")
      v(0.5em)
      line(length: 30%)
    })

    // ── Abstract ─────────────────────────────────────────────
    if abstract != none {
      page({
        heading(level: 1, numbering: none, "Abstract")
        abstract
      })
    }

    // ── Impact Statement ─────────────────────────────────────
    if impact-statement != none {
      page({
        heading(level: 1, numbering: none, "Impact Statement")
        impact-statement
      })
    }

    // ── Acknowledgements ─────────────────────────────────────
    if acknowledgements != none {
      page({
        heading(level: 1, numbering: none, "Acknowledgements")
        acknowledgements
      })
    }

    // ── Dedication ───────────────────────────────────────────
    if dedication != none {
      page(align(center + horizon, emph(dedication)))
    }

    // ── Table of Contents ────────────────────────────────────
    page({
      heading(level: 1, numbering: none, "Contents")
      outline(
        title: none,
        depth: 3,
        indent: auto,
      )
    })
    // ── Table of Notation ────────────────────────────────────
    if show-list-of-notation {
      page({
        heading(level: 1, numbering: none, "Table of Symbols")
        include "ucl-notation.typ"
      })
    }
    // ── Table of Acronyms ────────────────────────────────────
    if show-list-of-notation {
      page({
        heading(level: 1, numbering: none, "Table of Acronyms")
        include "ucl-notation.typ"
      })
    }

    // ── List of Figures ──────────────────────────────────────
    if show-list-of-figures {
      page({
        heading(level: 1, numbering: none, "List of Figures")
        outline(
          title: none,
          target: figure.where(kind: image),
        )
      })
    }

    // ── List of Tables ───────────────────────────────────────
    if show-list-of-tables {
      page({
        heading(level: 1, numbering: none, "List of Tables")
        outline(
          title: none,
          target: figure.where(kind: table),
        )
      })
    }
    // ── List of Algorithms ───────────────────────────────────────

    if show-list-of-algorithms {
      page({
        heading(level: 1, numbering: none, "List of Algorithms")
        outline(
          title: none,
          target: figure.where(kind: "algorithm"),
        )
      })
    }
  }


  // ────────────────────────────────────────────────────────────
  //  MAIN BODY
  // ────────────────────────────────────────────────────────────
  {
    set page(
      numbering: "1",
      header: context {
        let current = counter(page).get().first()
        let h = query(
          selector(heading.where(level: 1)).before(here()),
        )
        if h.len() > 0 {
          let title = h.last().body
          set text(size: font-size * 0.85)
          if calc.odd(current) {
            align(right, title)
          } else {
            align(left, title)
          }
          v(-0.4em)
          line(length: 100%, stroke: 0.4pt)
        }
      },
      footer: context {
        let current = counter(page).get().first()
        set text(size: font-size * 0.85)
        if calc.odd(current) {
          align(right, str(current))
        } else {
          align(left, str(current))
        }
      },
    )

    counter(page).update(1)
    body
  }
}
// ============================================================
//  For Chapter headings
// Chapter 1, 2 etc.
// Will also handle references with @
// ============================================================

// ============================================================
//  For Appendix headings
// Appendix A, B etc.
// Will also handle references with @
// ============================================================

#let appendix(body) = {
  show heading.where(level: 1): set heading(numbering: "A", supplement: [Appendix])
  body
}
// ============================================================
//  For unnumbered chapter (e.g. Introduction, Conclusion)
// ============================================================
#let unnumbered-chapter(title, body) = {
  heading(level: 1, numbering: none, title)
  body
}

// ============================================================
//  Function to auto-include files from a directory
//  USAGE: include-files("directory", ("A", "B"))
// Do NOT put a trailing / for the directory
// ============================================================
#let include-files(directory, list-of-files) = [
  #for file in list-of-files {
    include directory + "/" + file + ".typ"
  }
]
