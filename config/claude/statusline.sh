#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

COST_FMT=$(printf '$%.2f' "$COST")

# Render a 10-cell bar for a 0-100 percentage, coloured (dark/muted shades)
# green when low and shifting to red as the limit fills up.
bar() {
  local pct rounded filled color track="\033[38;5;240m" reset="\033[0m" i out=""
  rounded=$(printf '%.0f' "$1")
  filled=$(( rounded / 10 ))
  # Any nonzero usage shows at least one cell so it isn't mistaken for empty.
  [ "$filled" -eq 0 ] && [ "$rounded" -gt 0 ] && filled=1
  # Dark 256-colour shades: green -> olive -> orange -> red.
  if   [ "$rounded" -ge 90 ]; then color="\033[38;5;88m"   # dark red
  elif [ "$rounded" -ge 75 ]; then color="\033[38;5;130m"  # dark orange
  elif [ "$rounded" -ge 50 ]; then color="\033[38;5;100m"  # dark olive/yellow
  else                             color="\033[38;5;22m"   # dark green
  fi
  # Filled cells take the severity colour; the empty track stays dim grey so
  # the bar's length is always visible.
  for ((i = 0; i < 10; i++)); do
    if [ "$i" -lt "$filled" ]; then out+="${color}▓"; else out+="${track}░"; fi
  done
  printf '%b%b' "$out" "$reset"
}

# Max plan usage limits (Claude.ai subscribers only; absent until first API
# response, and each window may be independently missing).
FIVE_H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
WEEK=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

LIMITS=""
[ -n "$FIVE_H" ] && LIMITS="5h $(bar "$FIVE_H")"
[ -n "$WEEK" ] && LIMITS="${LIMITS:+$LIMITS  }7d $(bar "$WEEK")"

LINE="[$MODEL] 💰 $COST_FMT"
[ -n "$LIMITS" ] && LINE="$LINE | $LIMITS"
echo "$LINE"
