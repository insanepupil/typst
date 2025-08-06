// Title Page
#set text(font: "Equity B", size: 13pt)
#set page(
  paper: "us-letter",
  margin: (top: 1in, bottom: 1in, left: 1in, right: 1in),
  numbering: none,
)

#align(left)[
  #set text(font: "Equity B Caps", size: 13pt)
  SUPREME COURT OF THE STATE OF NEW YORK \
  NEW YORK COUNTY
]

// Case caption
#grid(
  columns: (1.8fr, 1fr),
  column-gutter: 1em,
  [
    #rect(
      width: 100%,
      stroke: (top: .5pt, right: .5pt, bottom: .5pt, left: none),
      inset: 1em,
    )[
      #set text(font: "Equity B", size: 13pt)
      #set par(first-line-indent: 0pt)
      #strong[The People of the State of New York]
      #v(1em)
      #align(center)[– against –]
      #v(1em)
      #strong[James S. Right],
      #v(1em)
      #align(right)[Defendant.]
    ]
  ],
  [
    #set text(font: "Equity B", size: 13pt)
    #set par(first-line-indent: 0pt)
    #v(1em)
    Indictment No. 8675309-25
    #line(length: 100%, stroke: 0.5pt)
    #strong[Memorandum of Law]
  ],
)

// Attorney Info
#set text(font: "Equity B", size: 13pt)
#align(bottom + right)[
  #block(
    width: auto,
    align(left)[
      #set par(first-line-indent: 0pt)
      The Law Office of Cadmium Q. Eaglefeather, PLLC \
      #v(1em)
      Cadmium Q. Eaglefeather \
      1234 Avenue of the Americas \ New York, New York 10025 \ (212) 555-5555
      #v(1em)
      #emph[Counsel for James Right]
    ],
  )
]
#pagebreak()

#let cases-alphabet = state("cases-alphabet", ())

#let case(case-name, reporter, pincite, court-year) = {
  let full-citation = (
    case-name + ", " + reporter + ", " + pincite + " " + court-year
  )
  heading(level: 7, outlined: false)[#full-citation]
  [#emph[#case-name], #reporter, #pincite, #court-year]
}

#show heading.where(level: 7): none

#let statutes-alphabet = state("statutes-alphabet", ())

#let statute(book, symbol, provision, subdivision) = {
  let full-citation = book + " " + symbol + " " + provision + " " + subdivision
  heading(level: 8, outlined: false)[#full-citation]
  [#book #symbol #provision #subdivision]
}

#show heading.where(level: 8): none

#let cases-outline() = context {
  let case-cites = query(selector(heading.where(level: 7)))

  let case-citation-map = (:)
  for case-cite in case-cites {
    let case-citation-text = if case-cite.body.has("text") {
      case-cite.body.text
    } else {
      ""
    }
    if case-citation-text != "" {
      if case-citation-text not in case-citation-map {
        case-citation-map.insert(case-citation-text, ())
      }
      let page-num = counter(page).at(case-cite.location()).first()
      // Only add page number if it's not already in the list
      if page-num not in case-citation-map.at(case-citation-text) {
        case-citation-map.at(case-citation-text).push(page-num)
      }
    }
  }

  // Sort the citations alphabetically
  let sorted-citations = case-citation-map.keys().sorted()

  [#strong[Cases] \ ]

  sorted-citations
    .map(case-citation-text => {
      let parts = case-citation-text.split(", ")
      let case-name = if parts.len() > 0 { parts.first() } else {
        case-citation-text
      }
      let rest = if parts.len() > 3 {
        ", " + parts.at(1) + ", " + parts.at(3)
      } else if parts.len() > 1 {
        ", " + parts.slice(1).join(", ")
      } else {
        ""
      }

      // Replace square brackets with parentheses for outline
      let rest-converted = rest.replace("[", "(").replace("]", ")")

      let first-letter = case-citation-text.first()
      context if (first-letter not in cases-alphabet.get()) {
        cases-alphabet.update(current => current + (first-letter,))
      }

      // Get all page numbers for this citation and join with commas
      let page-nums = case-citation-map
        .at(case-citation-text)
        .map(str)
        .join(", ")

      h(4pt) + emph[#case-name] + rest-converted
      box(width: 1fr, repeat[.])
      [#page-nums]
    })
    .join([ \ ])
}

#let statutes-outline() = context {
  let statute-cites = query(selector(heading.where(level: 8)))

  // Group headings by citation text to collect all page numbers
  let statute-citation-map = (:)
  for statute-cite in statute-cites {
    let statute-citation-text = if statute-cite.body.has("text") {
      statute-cite.body.text
    } else {
      ""
    }
    if statute-citation-text != "" {
      if statute-citation-text not in statute-citation-map {
        statute-citation-map.insert(statute-citation-text, ())
      }
      let page-num = counter(page).at(statute-cite.location()).first()
      // Only add page number if it's not already in the list
      if page-num not in statute-citation-map.at(statute-citation-text) {
        statute-citation-map.at(statute-citation-text).push(page-num)
      }
    }
  }

  // Sort the citations alphabetically
  let sorted-citations = statute-citation-map.keys().sorted()

  [#strong[Statutes] \ ]

  sorted-citations
    .map(statute-citation-text => {
      // Replace square brackets with parentheses for outline
      let citation-converted = statute-citation-text
        .replace("[", "(")
        .replace("]", ")")

      let first-letter = statute-citation-text.first()
      context if (first-letter not in statutes-alphabet.get()) {
        statutes-alphabet.update(current => current + (first-letter,))
      }

      // Get all page numbers for this citation and join with commas
      let page-nums = statute-citation-map
        .at(statute-citation-text)
        .map(str)
        .join(", ")

      h(4pt) + citation-converted
      box(width: 1fr, repeat[.])
      [#page-nums]
    })
    .join([ \ ])
}

#show heading.where(level: 1): set text(
  size: 13pt,
  weight: "bold",
  font: "Equity B Caps",
)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): it => { upper(it.body) }



#counter(page).update(1)

//Table Page Settings
#set text(font: "Equity B", size: 12pt)
#set page(
  paper: "us-letter",
  margin: (top: 1in, bottom: 1in, left: 1.5in, right: 1.5in),
  numbering: "i",
  number-align: center,
)

//Table of Contents (has to be in block of little i page numbering breaks)
#block(width: 100%)[
  #set text(font: "Equity B Caps", size: 13pt)
  #align(center)[#strong[CONTENTS]]
]
#set text(font: "Equity B", size: 13pt)
#outline(
  title: none,
  depth: 6,
)
#pagebreak()

//Table of Authorities (Authorities is level 1 heading so table of contents can track.)
= Authorities
#set text(font: "Equity B", size: 13pt)
#cases-outline()

#statutes-outline()

#pagebreak()
#counter(page).update(1)
#set page(
  numbering: "1",
  number-align: center,
)

#let custom-numbering(..nums) = {
  let levels = nums.pos()
  let current-level = levels.len() - 1
  let current-num = levels.last()
  if current-level == 1 {
    numbering("I", current-num) + "."
  } else if current-level == 2 {
    numbering("A", current-num) + "."
  } else if current-level == 3 {
    numbering("1", current-num) + "."
  } else if current-level == 4 {
    numbering("a", current-num) + "."
  } else if current-level == 5 {
    numbering("i", current-num) + "."
  }
}

// Apply the custom numbering
#set heading(numbering: custom-numbering)

// Style headings. (All subs same indent per Garner.)
#show heading.where(level: 2): it => {
  set text(font: "Equity B", size: 13pt, weight: "bold")
  pad(left: 0.0in, it)
}
#show heading.where(level: 3): it => {
  set text(font: "Equity B", size: 13pt, weight: "bold")
  pad(left: 0.25in, it)
}
#show heading.where(level: 4): it => {
  set text(font: "Equity B", size: 13pt, weight: "bold")
  pad(left: 0.25in, it)
}
#show heading.where(level: 5): it => {
  set text(font: "Equity B", size: 13pt, weight: "bold")
  pad(left: 0.25in, it)
}
#show heading.where(level: 6): it => {
  set text(font: "Equity B", size: 13pt, weight: "bold")
  pad(left: 0.25in, it)
}
== Main Heading
#v(6pt)
#set par(first-line-indent: .25in, leading: 13pt)
#set text(font: "Equity B", size: 13pt)

Lorem ipsum dolor sit amet, consectetur adipiscing elit. In #case("Miranda v Arizona", "384 U.S. 436", "444", "(1966)"), sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam in #case("Brown v Board of Education", "347 U.S. 483", "492", "(1954)") quis nostrud exercitation ullamco.

=== Second Level Heading

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua in #statute("CPL", "§", "140.10", "[1][a] (2020)") ut enim ad minim veniam. Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat in #statute("18 U.S.C.", "§", "3553", "[a] (2018)") duis aute irure dolor.

==== Third Level Heading

Lorem ipsum dolor sit amet, consectetur adipiscing elit in #case("Apple v Orange", "100 F.3d 200", "205", "(2d Cir. 2010)") sed do eiusmod tempor incididunt ut labore et dolore magna aliqua in #case("Zebra Corp. v Alpha Inc.", "250 F.3d 150", "160", "(1st Cir. 2015)"). Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.

===== Fourth Level Heading

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua in #statute("CPLR", "", "4518", "[a]") ut enim ad minim veniam. Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea in #statute("Vehicle and Traffic Law", "§", "1192", "[2]") commodo consequat.

====== Fifth Level Heading

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua #case("Gideon v Wainwright", "372 U.S. 335", "344", "(1963)") ut enim ad minim veniam, quis nostrud exercitation ullamco laboris #case("Doe v Smith", "50 N.Y.2d 100", "110", "(1980)") nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit #case("Roe v Wade", "410 U.S. 113", "153", "(1973)") in voluptate velit esse cillum dolore.

=== Second Main Heading

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua in #statute("Penal Law", "§", "125.25", "[1]") ut enim ad minim veniam. Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat in #statute("Civil Practice Law and Rules", "§", "3101", "[a]") duis aute irure dolor.

=== Another Second Level

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua #case("Adams v Baker", "123 F.3d 456", "460", "(3d Cir. 2000)"), ut enim ad minim veniam, quis nostrud exercitation ullamco laboris #case("Wilson v Thompson", "789 F.2d 123", "130", "(9th Cir. 1995)"), nisi ut aliquip ex ea commodo consequat #case("Clark v Davis", "456 F.3d 789", "795", "(5th Cir. 2005)").

== Third Main Heading

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua #case("United States v Nixon", "418 U.S. 683", "705", "(1974)") ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat #statute("Federal Rules of Evidence", "Rule", "404", "[b]") duis aute irure dolor.

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. The holding in #case("Terry v Ohio", "392 U.S. 1", "20", "(1968)") permits brief investigative stops. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

==== Final Third Level

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua #statute("New York State Constitution", "Article", "I", "§ 6") ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat #case("Mapp v Ohio", "367 U.S. 643", "655", "(1961)") duis aute irure dolor in reprehenderit.

== Third Main Heading

More table authority testing here: #case("Adams v Baker", "123 F.3d 456", "460", "(3d Cir. 2000)"), #statute("CPL", "§", "140.10", "[1][a] (2020)"), #statute("CPL", sym.section, "140.10", "[1][b]")
