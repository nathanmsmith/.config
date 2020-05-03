// Based on Chirs Beams' rules.
// https://chris.beams.io/posts/git-commit/
module.exports = {
  rules: {
    'body-leading-blank': [2, 'always', true],
    'body-max-line-length': [2, 'always', 72],
    'header-max-length': [2, 'always', 50],
    'header-case': [2, 'always', 'sentence-case'],
    'header-full-stop': [2, 'never', '.'],
  },
}
