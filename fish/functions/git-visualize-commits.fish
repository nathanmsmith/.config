function git-visualize-commits
  # Parse arguments (default to month granularity)
  set -l granularity month
  if test (count $argv) -gt 0
    set granularity $argv[1]
  end
  
  set -l git_args --all
  set -l title_suffix ""
  
  switch $granularity
    case year
      set git_args $git_args --pretty=format:"%ad" --date=format:"%Y"
      set title_suffix "by Year"
    case month
      set git_args $git_args --pretty=format:"%ad" --date=format:"%Y-%m"
      set title_suffix "by Month"
    case date day
      set git_args $git_args --pretty=format:"%ad" --date=format:"%Y-%m-%d"
      set title_suffix "by Day"
  end

  set -l project_name (basename (pwd))
  
  git log $git_args | sort | uniq -c | awk -v project="$project_name" -v suffix="$title_suffix" '
  BEGIN {
      max = 0
      count = 0
  }
  {
      commits[count] = $1
      dates[count] = $2
      if ($1 > max) max = $1
      count++
  }
  END {
      scale = max / 60
      if (scale < 1) scale = 1

      print project " All-Time Commits " suffix
      print "Peak: " max " commits"
      print "Scale: each █ represents ~" int(scale) " commits"
      print ""

      for (i = 0; i < count; i++) {
          bars = int(commits[i] / scale)
          if (bars == 0 && commits[i] > 0) bars = 1
          printf "%s: ", dates[i]
          for (j = 0; j < bars; j++) printf "█"
          printf " (%d)\n", commits[i]
      }
  }'
end
