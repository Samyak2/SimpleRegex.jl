using Test

include("./SimpleRegex.jl")

@testset "Match one character" begin
    @test match_one("a", "a") == true
    @test match_one(".", "a") == true
    @test match_one(".", "b") == true
    @test match_one(".", "c") == true
    @test match_one("", "a") == true
    @test match_one("", "m") == true
    @test match_one("", "z") == true
    @test match_one("a", "z") == false
    @test match_one("z", "a") == false
    @test match_one("a", "b") == false
    @test match_one("a", "") == false
    @test match_one("b", "") == false
    @test match_one("c", "") == false
end

@testset "Match same length strings with only '.' in pattern" begin
    @test match("abc", "abc") == true
    @test match("a.c", "abc") == true
    @test match("...", "abc") == true
    @test match("..c", "abc") == true
    @test match("", "") == true
    @test match("", "abc") == true
    @test match("a.aa", "aaaa") == true

    @test match("a.c", "acb") == false
    @test match("abc", "acb") == false
    @test match("a..", "baa") == false
    @test match("..c", "acb") == false
    @test match("a", "b") == false
    @test match("a.aa", "aaab") == false
end

@testset "Match same length strings with '.' and '\$' in pattern" begin
    @test match("abc\$", "abc") == true
    @test match("a.c\$", "abc") == true
    @test match("...\$", "abc") == true
    @test match("..c\$", "abc") == true
    @test match("\$", "") == true
    @test match("", "abc") == true
    @test match("a.aa\$", "aaaa") == true
end

@testset "Same length strings with pattern starting with '^'" begin
    @test search("^abc", "abc") == true
    @test search("^a.c", "abc") == true
    @test search("^ab.", "abc") == true
    @test search("^.bc", "abc") == true
    @test search("^abc\$", "abc") == true
    @test search("^ab", "abc") == true
    @test search("^\$", "") == true

    @test search("^bc", "abc") == false
    @test search("^c", "abc") == false
    @test search("^b\$", "abc") == false
    @test search("^.c", "abc") == false
end

@testset "Search different length strings (simple)" begin
    @test search("ab", "abc") == true
    @test search("b", "abc") == true
    @test search("bc", "abc") == true
    @test search("c", "abc") == true
    @test search("abc", "abc") == true

    @test search("ac", "abc") == false
    @test search("a\$", "abc") == false 
    @test search("ba", "abc") == false
    @test search("f", "abc") == false
end

@testset "Patterns with '?' in them" begin
    @test search("ab?c", "abc") == true
    @test search("ab?c", "ac") == true
    @test search("abc?", "abccc") == true
    @test search("abcd?e", "aaaabcdeeeeeeee") == true
    @test search("abcd?e", "aaaabceeeeeeee") == true

    @test search("ab?c", "abbc") == false
    @test search("abc?", "aabbc") == true
    @test search("b?c", "abbccc") == true
    @test search("ab?c", "aaabasdsaklbasdnlc") == false
    @test search("a?", "aaaaa") == true
    @test search("", "hmm") == true
end

@testset "Patterns with '*' in them" begin
    @test search("ab*c", "abc") == true
    @test search("ab*c", "ac") == true
    @test search("ab*c", "abbbbbbbbbbbbc") == true
    @test search("ab*bc", "abbbbc") == true
    @test search("ab*bc", "abc") == true
    @test search("bc*", "aaabcccccc") == true
    @test search("a*", "") == true
    @test search("a*b*", "") == true
    @test search("a*b*", "a") == true
    @test search("a*b*", "b") == true
    @test search("a*b*", "aaabbbbbbb") == true
    @test search("a*", "bbbaaaccc") == true

    @test search("ab*c", "bbbaaaccc") == true
    @test search("ac*", "bbbaaaccc") == true
    @test search("a*", "bbbccc") == true
    @test search("a*bcd", "aaaaaabc") == false
end

