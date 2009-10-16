#!perl -T

use strict;
use warnings;
use Test::More tests => 45;


BEGIN { use_ok('Language::Dashrep'); };


#-------------------------------------------
#  Declare variables.

my ( $numeric_return_value ) ;
my ( $string_return_value ) ;
my ( $list_count ) ;
my ( $one_if_ok ) ;
my ( $dashrep_code ) ;
my ( $content_with_expanded_parameters ) ;
my ( $html_code ) ;
my ( @string_array_return_value ) ;


#-------------------------------------------
#  Test defining a hyphenated phrase
#  to be associated with its replacement text.

$numeric_return_value = &dashrep_define( "page-name" , "name of page" );
ok( $numeric_return_value eq 1, 'defined hyphenated phrase' );


#-------------------------------------------
#  Test getting defined hyphenated phrase.

$string_return_value = &dashrep_get_replacement( "page-name" );
ok( $string_return_value eq "name of page", "retrieved replacement text" );

$string_return_value = &dashrep_get_replacement( "phrase-not-defined" );
ok( $string_return_value eq "", "attempt to retrieve undefined phrase" );


#-------------------------------------------
#  Test defining second phrase and then
#  getting list of all defined phrases.

$numeric_return_value = &dashrep_define( "page-name-second" , "name of second page" );
ok( $numeric_return_value eq 1, 'defined hyphenated phrase' );

@string_array_return_value = &dashrep_get_list_of_phrases;
$list_count = $#string_array_return_value + 1 ;
ok( $list_count eq 2, "counted defined phrases" );

if ( $string_array_return_value[ 1 ] =~ /page/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "verified name in list of phrase names" );


#-------------------------------------------
#  Test deleting hyphenated phrase.

$numeric_return_value = &dashrep_define( "temporary-phrase" , "anything here" );

$string_return_value = &dashrep_delete( "temporary-phrase" );
ok( $numeric_return_value eq 1, 'deleted hyphenated phrase' );

$string_return_value = &dashrep_get_replacement( "temporary-phrase" );
ok( $string_return_value eq "", "attempt to retrieve deleted phrase" );

#-------------------------------------------
#  Specify Dashrep code that will be used in
#  tests below.

$dashrep_code = <<TEXT_TO_IMPORT;

*---- Do NOT change the following numbers or the tests will fail ----*
list-of-numbers: 3,12,7,13,4
--------

test-of-special-operators:
[-test-assignment = 17-]
[-should-be-17 = [-test-assignment-]-]
[-should-be-zero = [-zero-one-multiple: 0-]-]
[-should-be-one = [-zero-one-multiple: 1-]-]
[-should-be-multiple = [-zero-one-multiple: 2-]-]
[-should-be-size-zero = [-count-of-list: -]-]
[-should-be-size-one = [-count-of-list: 4-]-]
[-should-be-size-three = [-count-of-list: 4,5,6-]-]
[-should-be-count-zero = [-zero-one-multiple-count-of-list: -]-]
[-should-be-count-one = [-zero-one-multiple-count-of-list: 12-]-]
[-should-be-count-multiple = [-zero-one-multiple-count-of-list: [-list-of-numbers-]-]-]
[-should-be-item-three = [-first-item-in-list: [-list-of-numbers-]-]-]
[-should-be-item-four = [-last-item-in-list: [-list-of-numbers-]-]-]
[-should-be-empty = [-empty-or-nonempty: -]-]
[-should-be-nonempty = [-empty-or-nonempty: something-]-]
[-item-one = waltz-]
[-item-two = dance-]
[-should-be-same = [-same-or-not-same: [-item-one-]-[-item-one-]-]-]
[-should-be-not-same = [-same-or-not-same: [-item-one-]-[-item-two-]-]-]
[-action-showothervoterranking-[-same-or-not-same: [-input-validated-participantid-]-[-users-participant-id-]-]-]
[-should-be-sorted = [-sort-numbers: [-list-of-numbers-]-]-]
[-test-counter = 17-]
[-test-value = 3-]
nothing else
--------

test-of-comment-delimiters:
beginning text
*---- comment text ----*
middle text
/---- comment text ----/
ending text
--------

test-of-auto-increment:
[-auto-increment: test-counter-]
--------

test-of-unique-value:
[-unique-value: test-value-]
--------

non-breaking-space:
&nbsp;
--------

test-of-special-spacing:
abc no-space def one-space ghi jkl  span-non-breaking-spaces-begin mno pqr stu span-non-breaking-spaces-end vwx non-breaking-space yz
--------

test-of-special-line-phrases:
abc
empty-line
def
new-line
ghi
--------

test-of-tabs:
abc tab-here def tab-here ghi
--------

page-participants-list:
[-create-list-named: participant-names-full-]
[-auto-increment: test-counter-]
[-unique-value: test-value-]
format-begin-heading-level-1
words-web-page-title
format-end-heading-level-1
generated-list-named-participant-names-full
--------
entire-standard-web-page:
web-page-begin-1-of-2
web-page-begin-2-of-2
page-participants-list
web-page-end
--------
words-web-page-title:
List of participants
--------
tag-begin: < no-space
--------
tag-end: no-space >
--------
web-page-begin-1-of-2:
tag-begin !DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" tag-end
open-angle-bracket html tag-end
tag-begin head tag-end
tag-begin title tag-end
words-web-page-title
tag-begin /title tag-end
--------
web-page-begin-2-of-2:
tag-begin /head tag-end
new-line
tag-begin body tag-end
--------
web-page-end:
tag-begin /body tag-end
tag-begin /html tag-end
--------
format-begin-heading-level-1:
tag-begin h1 tag-end no-space
--------
format-end-heading-level-1:
no-space  tag-begin /h1 tag-end
--------

case-info-idlistparticipants: [-list-of-numbers-]
--------
template-for-list-named-participant-names-full: participant-fullname-for-participantid-[-parameter-participant-id-]
--------
parameter-name-for-list-named-participant-names-full:
parameter-participant-id
--------
list-of-parameter-values-for-list-named-participant-names-full:
[-case-info-idlistparticipants-]
--------
participant-fullname-for-participantid-3
James (Conservative)
---------------
participant-fullname-for-participantid-12
Nicole (Bloc Qu&eacute;b&eacute;cois)
---------------
participant-fullname-for-participantid-7
Eduard (Liberal)
---------------
participant-fullname-for-participantid-13
Robert (New Democratic)
---------------
participant-fullname-for-participantid-4
Diane (Conservative)
---------------
TEXT_TO_IMPORT


#-------------------------------------------
#  Test import hyphenated phrases with
#  replacement text.

$numeric_return_value = &dashrep_import_replacements( $dashrep_code );
if ( $numeric_return_value > 10 )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "imported replacements using Dashrep code" );


#-------------------------------------------
#  Test expanding parameters.

$content_with_expanded_parameters = &dashrep_expand_parameters( "page-participants-list" );
$numeric_return_value = &dashrep_define( "web-page-content" , $content_with_expanded_parameters );
if ( $content_with_expanded_parameters ne 0 )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "expanded parameters" );


#-------------------------------------------
#  Test special operators.

$string_return_value = &dashrep_expand_parameters( "test-of-special-operators" );

$string_return_value = &dashrep_get_replacement( "should-be-17" );
ok( $string_return_value eq "17", "test equal sign assignment" );

$string_return_value = &dashrep_get_replacement( "should-be-zero" );
ok( $string_return_value eq "zero", "test special operator" );

$string_return_value = &dashrep_get_replacement( "should-be-one" );
ok( $string_return_value eq "one", "test one operator" );

$string_return_value = &dashrep_get_replacement( "should-be-multiple" );
ok( $string_return_value eq "multiple", "test multiple operator" );

$string_return_value = &dashrep_get_replacement( "should-be-size-zero" );
ok( $string_return_value eq "0", "test list-size operator for zero" );

$string_return_value = &dashrep_get_replacement( "should-be-size-one" );
ok( $string_return_value eq "1", "test list-size operator for one" );

$string_return_value = &dashrep_get_replacement( "should-be-size-three" );
ok( $string_return_value eq "3", "test list-size operator for three" );

$string_return_value = &dashrep_get_replacement( "should-be-count-zero" );
ok( $string_return_value eq "zero", "test zero count operator" );

$string_return_value = &dashrep_get_replacement( "should-be-count-one" );
ok( $string_return_value eq "one", "test one count operator" );

$string_return_value = &dashrep_get_replacement( "should-be-count-multiple" );
ok( $string_return_value eq "multiple", "test multiple count operator" );

$string_return_value = &dashrep_get_replacement( "should-be-item-three" );
ok( $string_return_value eq "3", "test first item in list operator" );

$string_return_value = &dashrep_get_replacement( "should-be-item-four" );
ok( $string_return_value eq "4", "test last item in list operator" );

$string_return_value = &dashrep_get_replacement( "should-be-empty" );
ok( $string_return_value eq "empty", "test empty operator" );

$string_return_value = &dashrep_get_replacement( "should-be-nonempty" );
ok( $string_return_value eq "nonempty", "test nonempty operator" );

$string_return_value = &dashrep_get_replacement( "should-be-same" );
ok( $string_return_value eq "same", "test same operator" );

$string_return_value = &dashrep_get_replacement( "should-be-not-same" );
ok( $string_return_value eq "not-same", "test not same operator" );

$string_return_value = &dashrep_get_replacement( "should-be-sorted" );
ok( $string_return_value eq "3,4,7,12,13", "test sort operator" );

$string_return_value = &dashrep_expand_parameters( "test-of-auto-increment" );
$string_return_value = &dashrep_get_replacement( "test-counter" );
ok( $string_return_value eq "18", "test auto-increment operator" );

$string_return_value = &dashrep_expand_parameters( "test-of-unique-value" );
$string_return_value = &dashrep_get_replacement( "test-value" );
ok( $string_return_value ne "3", "test unique-value operator" );


#-------------------------------------------
#  Test comment delimiters.

$string_return_value = &dashrep_get_replacement( "test-of-comment-delimiters" );
if ( $string_return_value !~ /comment/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test comment delimiters" );


#-------------------------------------------
#  Test expansion without special phrases.

$string_return_value = &dashrep_expand_phrases_except_special( "test-of-special-spacing" );
if ( $string_return_value =~ /abc no\-space def one\-space ghi jkl/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test expansion without special phrases" );


#-------------------------------------------
#  Test expansion of specific special phrases.

$string_return_value = &dashrep_expand_phrases( "abc  no-space  def" );
if ( $string_return_value =~ /abcdef/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test no-space directive" );

$string_return_value = &dashrep_expand_phrases( "abc  one-space  def" );
if ( $string_return_value =~ /abc def/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test one-space directive" );

$string_return_value = &dashrep_expand_phrases( "abc new-line  no-space  one-space  one-space  one-space  one-space  no-space  def" );
if ( $string_return_value =~ /abc\n    def/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test four-space indentation" );

$string_return_value = &dashrep_expand_special_phrases( "abc non-breaking-space def" );
if ( $string_return_value =~ /abc&nbsp;def/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test non-breaking-space directives" );

$string_return_value = &dashrep_expand_special_phrases( "jkl  span-non-breaking-spaces-begin mno pqr stu span-non-breaking-spaces-end vwx" );
if ( $string_return_value =~ /jkl mno&nbsp;pqr&nbsp;stu vwx/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test non-breaking-spaces-begin/end directive" );

$string_return_value = &dashrep_expand_special_phrases( "abc tab-here def" );
if ( $string_return_value =~ /abc\tdef/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test tab-here directive" );

$string_return_value = &dashrep_expand_special_phrases( "abc empty-line def new-line ghi" );
if ( $string_return_value =~ /abc\n\ndef\nghi/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test empty-line and new-line directives" );


#-------------------------------------------
#  Test special line-related phrases.

$string_return_value = &dashrep_expand_phrases( "test-of-special-line-phrases" );
if ( $string_return_value =~ /\n/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test line break phrase" );

$string_return_value = &dashrep_expand_special_phrases( "test-of-special-line-phrases" );
if ( $string_return_value =~ /\n/ )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test special-phrase line break" );


#-------------------------------------------
#  Test tab-here phrase.

$string_return_value = &dashrep_expand_phrases( "test-of-tabs" );
if ( $string_return_value ne "abc\tdef\tghi" )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "test tab-here phrase" );


#-------------------------------------------
#  Test expanding a single hyphenated
#  phrase into an entire web page, including
#  a table that lists participants.

$html_code = &dashrep_expand_phrases( "entire-standard-web-page" );
if ( length( $html_code ) gt 100 )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "expanded hyphenated phrase using all replacements" );

if ( ( $html_code =~ /List of participants/ ) && ( $html_code =~ /Nicole/ ) )
{
    $one_if_ok = 1 ;
} else
{
    $one_if_ok = 0 ;
}
ok( $one_if_ok eq 1, "found specific expanded text" );


#-------------------------------------------
#  Test setting the runaway limit (to stop
#  endless loops).

$string_return_value = &dashrep_set_runaway_limit( 7000 ) ;
ok( $numeric_return_value eq 1, 'set new runaway limit' );


#-------------------------------------------
#  As a further test, you can print
#  $html_code to a file with the .html
#  extension and open the file with a
#  web browser.

# print $html_code ;


#-------------------------------------------
#  All done testing.
