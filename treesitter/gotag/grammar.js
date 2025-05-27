/**
 * @file Parser for go struct tag
 * @author Ephemeral <theephemeral.txt@gmail.com>
 * @license GPL-3.0
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
  name: "gotag",

  rules: {
    source_file: ($) => repeat($.struct_tag),

    struct_tag: ($) =>
      seq(field("name", $.tag_identifier), ":", field("value", $.tag_value)),

    tag_identifier: () => new RustRegex("(?i)[a-z_][a-z0-9_]*"),
    key_identifier: () => new RustRegex('[^,:"]+'), // stops at comma or colon
    option_identifier: () => new RustRegex('[^,^"]+'),

    tag_value: ($) =>
      seq(
        '"',
        field("key", $.key_identifier),
        repeat(seq(",", field("option", $.option_identifier))),
        '"',
      ),
  },
});
