# Defined in - @ line 1
function gmm --description 'alias gmm git checkout master; git fetch'
	git checkout master; git fetch $argv;
end
