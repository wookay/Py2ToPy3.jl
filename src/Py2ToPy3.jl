module Py2ToPy3

export change

function patexcept(line)
    r = Regex("(.*)(except .*)(, )(.*:)")
    m = match(r, line)
    (m, m isa RegexMatch ? string(m[1], m[2], " as ", m[4]) : line)
end

function patraise(line)
    r = Regex("(.*)(raise [^,]*)(, )(.*)")
    m = match(r, line)
    (m, m isa RegexMatch ? string(m[1], m[2], "(", m[4], ")") : line)
end

function patprint(line)
    r = Regex("(.*)(print )(.*)")
    m = match(r, line)
    (m, m isa RegexMatch ? string(m[1], "print(", m[3], ")") : line)
end

function patpickle(line)
    r = Regex("(.*)(import )(cPickle)(.*)")
    m = match(r, line)
    (m, m isa RegexMatch ? string(m[1], m[2], "pickle", m[4]) : line)
end

function upgrade(filename::String, overwrite::Bool)
    io = IOBuffer()
    for line in readlines(filename)
        for f in (patexcept, patraise, patprint, patpickle)
            m, s = f(line)
            if m isa RegexMatch
                line = s
                break
            end
        end
        println(io, line)
    end
    s = String(take!(io))
    if overwrite
        write(filename, s)
    else
        print(s)
    end
end

function change(filenames=ARGS; overwrite=false)
    if isempty(filenames)
    else
        for filename in filenames
            upgrade(filename, overwrite)
        end
    end
end

end # module Py2ToPy3
