# Defined in - @ line 1
function gg --description 'alias gg git log --oneline --graph --decorate --all'
	git log --oneline --graph --decorate --all $argv;
end
