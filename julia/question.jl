# implementation of the question function in julia
function question(prompt::AbstractString, valid::AbstractVector{<:AbstractString})
    loopprompt = isempty(valid) ? "" : '(' * join(valid, ", ") * ')'
    while true
        print(prompt, '\n', loopprompt, ": ")
        inp = readline(stdin)
        (isempty(valid) || inp in valid) && return inp
        println("\"$inp\" is not a valid answer", '\n')
    end
end

question("foo", ["bar", "baz"])
