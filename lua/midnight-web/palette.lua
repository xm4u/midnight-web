local classic = {
  bg = "#080F1C",
  surface = "#101B2B",
  surface_alt = "#142238",
  selection = "#233750",
  line = "#101A29",
  border = "#26374C",
  tree_line = "#55687F",

  fg = "#CBD6E6",
  fg_soft = "#A8BBCD",
  muted = "#71849D",

  red = "#D97B87",
  red_error = "#E18B91",
  blue = "#86B6E0",
  cyan = "#9CC2CF",
  green = "#A4C2A4",
  amber = "#D9B77E",
  lavender = "#B7A3D6",
  peach = "#DDA08A",
  periwinkle = "#9EAED1",

  error_bg = "#251A25",
  warning_bg = "#252116",
  info_bg = "#172330",
  success_bg = "#17251F",
  diff_add = "#193027",
  diff_delete = "#301E28",
  diff_change = "#192B3A",
}

local function derive(overrides)
  local palette = {}
  for name, color in pairs(classic) do
    palette[name] = color
  end
  for name, color in pairs(overrides) do
    palette[name] = color
  end
  return palette
end

return {
  classic = classic,

  -- Cool daylight surfaces with muted accents. Keep every role explicit so
  -- Light cannot inherit a dark diagnostic or diff background from Classic.
  light = {
    bg = "#F5F7FB",
    surface = "#FFFFFF",
    surface_alt = "#EAF0F7",
    selection = "#D9E5F2",
    line = "#EAF0F7",
    border = "#D8E0EB",
    tree_line = "#8190A4",

    fg = "#243247",
    fg_soft = "#243247",
    muted = "#5A6B81",

    red = "#B73E54",
    red_error = "#B73E54",
    blue = "#2864A0",
    cyan = "#287486",
    green = "#3A7858",
    amber = "#94601B",
    lavender = "#7953A2",
    peach = "#A8523C",
    periwinkle = "#536BA5",

    error_bg = "#F8E9ED",
    warning_bg = "#F8F0E2",
    info_bg = "#EAF0F7",
    success_bg = "#E8F2EC",
    diff_add = "#E8F2EC",
    diff_delete = "#F8E9ED",
    diff_change = "#EAF0F7",
  },

  -- Preserve Classic's full semantic foreground palette and darken only the
  -- editor surfaces. The existing foreground contrast therefore increases.
  deep = derive({
    bg = "#050A14",
    surface = "#0C1626",
    surface_alt = "#101D30",
    selection = "#1C2D44",
    line = "#09121F",
    border = "#1B2A3E",
    tree_line = "#52657B",
    error_bg = "#20151F",
    warning_bg = "#211D12",
    info_bg = "#111D2A",
    success_bg = "#132119",
    diff_add = "#14291F",
    diff_delete = "#2A1925",
    diff_change = "#14263A",
  }),

  -- Soft lowers chroma and contrast between secondary surfaces while retaining
  -- readable text and the same semantic role structure as Classic.
  soft = derive({
    bg = "#0A1320",
    surface = "#121D2D",
    surface_alt = "#172537",
    selection = "#263950",
    line = "#111A29",
    border = "#29394F",
    tree_line = "#596B82",

    fg = "#C4CFDF",
    fg_soft = "#A8B6C8",
    muted = "#8291A5",

    red = "#CE818C",
    red_error = "#D98E96",
    blue = "#8EAFCE",
    cyan = "#9DB9C4",
    green = "#A4BBA5",
    amber = "#D2B37F",
    lavender = "#B2A0CB",
    peach = "#D5A18F",
    periwinkle = "#A0ADC8",

    error_bg = "#241B26",
    warning_bg = "#252216",
    info_bg = "#182432",
    success_bg = "#19261F",
    diff_add = "#1A2C25",
    diff_delete = "#2D1F29",
    diff_change = "#1A2A38",
  }),
}
