@domain:documentation-site @area:typography-and-layout @from:docs/stylesheets
Feature: Presenting the documentation without network-loaded assets
  Gives readers a polished docs site (gradient hero, feature cards, readable tables) that loads no fonts or assets from the network, which helps privacy and offline reading.

  Background:
    Given the kubectl-versioned documentation site is published

  @id:documentation-site.typography-and-layout.001 @rule:documentation-site.typography-and-layout.no-network-fonts @inferred @source:docs/stylesheets/extra.css#:root
  Scenario: The docs render with system fonts and download no web font
    Given the reader's machine has no network access to font or CDN hosts
    When the reader opens a docs page
    Then body text uses the system sans-serif stack starting with -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto
    And code uses the system monospace stack starting with ui-monospace, SFMono-Regular
    And no font or stylesheet is requested from a third-party host

  @id:documentation-site.typography-and-layout.002 @rule:documentation-site.typography-and-layout.hero-gradient-title @inferred @source:docs/stylesheets/extra.css#.md-typeset .hero
  Scenario: The docs home page opens with a centred hero whose title is in the accent gradient
    Given the docs home page contains a hero block with a title, a tagline and buttons
    When a reader opens the docs home page
    Then the hero is centred, with its title in large type filled with the #38bdf8 to #3b82f6 gradient
    And the tagline appears below it in muted text
    And primary buttons are pill-shaped with the accent gradient and white text

  @id:documentation-site.typography-and-layout.003 @rule:documentation-site.typography-and-layout.feature-cards-respond-to-hover @inferred @source:docs/stylesheets/extra.css#.md-typeset .grid.cards > ul > li @questionable
  Scenario: Feature cards lift and take on an accent border when hovered
    Given a docs page shows a grid of feature cards
    When the reader hovers over a card
    Then the card rises slightly and gains a soft shadow
    And its border is tinted with the #38bdf8 accent
    And the card icons are shown in the #38bdf8 accent at all times

  @id:documentation-site.typography-and-layout.004 @rule:documentation-site.typography-and-layout.tables-as-rounded-cards @inferred @source:docs/stylesheets/extra.css#.md-typeset table:not([class]) @questionable
  Scenario: Plain tables appear as rounded, bordered cards with compact uppercase headers
    Given a docs page contains a plain Markdown table wider than a narrow screen
    When a reader views the page on a narrow screen
    Then the table has rounded corners and a hairline border
    And its header cells are uppercase, in small semi-bold text
    And overflow outside the table's own box is hidden
