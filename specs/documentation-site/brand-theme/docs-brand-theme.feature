@domain:documentation-site @area:brand-theme @from:docs/stylesheets
Feature: Keeping the documentation on one brand palette
  Gives readers of the splash page and the rendered docs one consistent blue look, with readable links in both light and dark mode and no borrowed branding.

  Background:
    Given the kubectl-versioned documentation site is published with its splash page at / and the rendered docs at /docs/

  @id:documentation-site.brand-theme.001 @rule:documentation-site.brand-theme.single-shared-accent-pair @inferred @source:docs/stylesheets/extra.css#:root @questionable
  Scenario: The splash page and the docs show the same accent colours
    Given the site accent pair is sky blue #38bdf8 and blue #3b82f6
    When a reader opens the splash page and then the docs
    Then the splash title and its main button are drawn in a #38bdf8 to #3b82f6 gradient
    And the docs primary colour, and links in light mode, use #3b82f6
    And the docs interactive accent uses #38bdf8

  @id:documentation-site.brand-theme.002 @rule:documentation-site.brand-theme.links-legible-per-scheme @inferred @source:docs/stylesheets/extra.css#[data-md-color-scheme="slate"]
  Scenario Outline: Links stay readable in both light and dark mode
    Given the reader's docs colour scheme is <scheme>
    When the reader views a docs page
    Then links are shown in <link_colour>
    And the page background is <background>

    Examples:
      | scheme       | link_colour | background                                     |
      | light        | #3b82f6     | the default white                              |
      | dark (slate) | #38bdf8     | #0b0f1a, with the header and tabs also #0b0f1a |

  @id:documentation-site.brand-theme.003 @rule:documentation-site.brand-theme.no-placeholder-logo @inferred @source:docs/stylesheets/extra.css#.md-header__button.md-logo
  Scenario: The docs show no stand-in logo
    Given the project has no logo of its own
    When a reader views the docs header or the navigation title
    Then no logo icon is shown, so Material's generic book glyph does not appear
