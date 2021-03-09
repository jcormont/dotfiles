# Defined in - @ line 1
function gg --description 'Git graph'
  git log --graph --decorate --all --date-order --pretty="%C(green)%h%C(reset) %C(italic blue)%ar%C(reset) - %s" $argv;
end
