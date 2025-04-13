```
for color in (cat 'Night Owl-color-theme.json' | rg '#([A-Fa-f0-9]{3,10})' -o |
sort | uniq -i); ./colorprint.sh $color; end
```

For referring to night-owl colors
