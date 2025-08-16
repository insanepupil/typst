#set text(font: "Equity B", size: 12pt)
#set page(
  paper: "us-letter",
  margin: (top: 1in, bottom: 1in, left: 1.85in, right: 1.85in),
  numbering: none,
  header: context {
    if counter(page).get().first() > 1 [
      #datetime.today().display("[month repr:long] [day], [year]") \
      Page #counter(page).display("1 of 1", both: true)
      #v(1em)
    ]
  },
)
#show heading.where(level: 1): it => [
  #set text(
    font: "Concourse 6",
    size: 12pt,
  )
  #v(10pt)
  #it
  #v(10pt)
]

// Letterhead
#align(center)[
  #text(
    size: 14pt,
    fill: rgb("0C426A"),
  )[The Law Office of Cadmium Q. Eaglefeather] \
  #text(
    font: "Equity B Caps",
    size: 11pt,
    tracking: 1.5pt,
  )[attorneys & counselors at law] \
  #text(font: "Equity B", size: 10pt)[
    1234 Avenue of the Americas \
    New York, New York 12345 \
    Tel 212 555 5555 | 212 777 7777
  ]
]

#v(2em)

#set text(font: "Equity B", size: 12pt)
#h(2.75in) #upper(datetime.today().display("[day] [MONTH repr:short] [year]")) \

#set text(font: "Equity B", size: 12pt)

#v(4em)

// Address block
RECIPIENT \
STREET ADDRESS \
STREET ADDRESS 2\
CITY, STATE, ZIP\
EMAIL\

#let re_table(it) = table(
  columns: (.5in, auto),
  inset: 0pt,
  stroke: none,
  table.header([#strong[Re:]], it),
)

#re_table[#emph[People v Sandwich]\; Docket No. 555]

Dear TK:
#set par(leading: 0.65em)
#lorem(50)

= Background

#lorem(50)

#lorem(50)

= Summary

#lorem(50)

#lorem(50)

= Conclusion

#lorem(50)

#v(1em)

#set par(first-line-indent: 0pt)

#set text(font: "Equity B", size: 12pt)
#pad(left: 2.4in)[
  Respectfully,
  #v(4em)

  #h(2.5in)
  #line(length: 100%, stroke: .5pt)
  #v(-10pt)
  Cadmium Q. Eaglefeather
  _Counsel for TK_ \
]

#v(1em)
Encl.\
CC\
dictated but not read\

