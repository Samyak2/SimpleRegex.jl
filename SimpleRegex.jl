function match_one(pattern::Char, text::Char)
    return match_one(string(pattern), string(text))
end

function match_one(pattern::String, text::String)
    if pattern == ""  # empty pattern matches any text
        return true
    elseif text == "" # non-empty pattern does not match empty text
        return false
    elseif pattern == "." # '.' matches any text
        return true
    else
        return pattern == text # check if pattern and text have same char
    end
end

function match_question(pattern, text)
    pattern == "" ||
    (text != "" && match_one(pattern[1], text[1]) && match(pattern[3:end], text[2:end])) ||
    match(pattern[3:end], text)
end

function match_star(pattern, text)
    pattern == "" ||
    (text != "" && match_one(pattern[1], text[1]) && match(pattern, text[2:end])) ||
    match(pattern[3:end], text)
end

function match(pattern, text)
    if pattern == ""
        return true
    elseif pattern == "\$" && text == ""
        return true
    elseif length(pattern) > 1 && pattern[2] == '?'
        return match_question(pattern, text)
    elseif length(pattern) > 1 && pattern[2] == '*'
        return match_star(pattern, text)
    else
        return text != "" && match_one(pattern[1], text[1]) && match(pattern[2:end], text[2:end])
    end
end

function search(pattern, text)
    if pattern == ""
        return true
    elseif pattern[1] == '^'
        return match(pattern[2:end], text)
    else
        return match(".*" * pattern, text)
    end
end

