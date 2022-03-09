/// • enum to decide the clickable area of Expandable widgets.
enum Clickable {
  none,
  everywhere,
  firstChildOnly,
}

/// • enum for arrowLocation (which is a property of ExpandableText).
enum ArrowLocation {
  top,
  right,
  bottom,
  left,
}

/// • helper types for ExpandableText.
enum Helper {
  none,
  text,
  arrow,
}
