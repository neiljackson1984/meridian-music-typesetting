\version "2.18.2"
#(ly:set-option 'point-and-click #f)
\include "utility.liy"
\include "notesandwords.liy"


 

 
#(set-global-staff-size 15.5)
#(set-default-paper-size "letter")

\paper
{
	% line-width = 6.5\in
    top-margin = 0.4\in
    left-margin = 1\in
    right-margin = 1\in
    bottom-margin = 0.4\in
    two-sided = ##t
    inner-margin=0.9\in
    outer-margin=0.9\in
    binding-offset=0.2\in
    
    %=== The below parameters are in units of staff-spaces (The staff-space is the distance between two adjacent staff lines) 
    % markup-system-spacing:  the distance between a (title or top-level) markup and the system that follows it.
        %DEFAULT:    markup-system-spacing = #'((basic-distance . 5) (padding . 0.5) (stretchability . 30))
        markup-system-spacing #'padding = #10
    
    % score-markup-spacing:   the distance between the last system of a score and the (title or top-level) markup that follows it.
        %DEFAULT:  score-markup-spacing = #'((basic-distance . 12) (padding . 0.5) (stretchability . 60))
        
    % score-system-spacing:   the distance between the last system of a score and the first system of the score that follows it, when no (title or top-level) markup exists between them.
        %DEFAULT: score-system-spacing = #'((basic-distance . 14) (minimum-distance . 8) (padding . 1) (stretchability . 120))
        score-system-spacing #'basic-distance = #20
    
    % system-system-spacing:  the distance between two systems in the same score.
        %DEFAULT:  system-system-spacing = #'((basic-distance . 12) (minimum-distance . 8) (padding . 1) (stretchability . 60))
        system-system-spacing #'basic-distance = #20
    
    % markup-markup-spacing:  the distance between two (title or top-level) markups.
        %DEFAULT:  markup-markup-spacing = #'((basic-distance . 1) (padding . 0.5))
        
    % last-bottom-spacing:    the distance from the last system or top-level markup on a page to the bottom of the printable area (i.e. the top of the bottom margin).
        %DEFAULT:  last-bottom-spacing = #'((basic-distance . 1) (minimum-distance . 0) (padding . 1) (stretchability . 30))
        last-bottom-spacing #'basic-distance = #10
    
    % top-system-spacing:     the distance from the top of the printable area (i.e. the bottom of the top margin) to the first system on a page, when there is no (title or top-level) markup between the two.
        %DEFAULT:  top-system-spacing = #'((basic-distance . 1) (minimum-distance . 0) (padding . 1))
        top-system-spacing #'basic-distance = #11
        
    % top-markup-spacing:     the distance from the top of the printable area (i.e. the bottom of the top margin) to the first (title or top-level) markup on a page, when there is no system between the two. 
        %DEFAULT:  top-markup-spacing = #'((basic-distance . 0) (minimum-distance . 0) (padding . 1))
        top-markup-spacing #'basic-distance = #8

	
	print-first-page-number = ##t
	% #(set-paper-size "letter")
	% ragged-bottom = ##t
	print-all-headers = ##t
	% system-count = #4

	% scoreTitleMarkup = #bookTitleMarkup 
}


scorecontents = {
	\new ChoirStaff
	<<

		\new Staff = "soprano-staff" <<
			\set Staff.instrumentName = "soprano"
            \clef treble
			\new Voice = "dummyKeepAliveVoiceForSopranoStaff" { \dummyKeepAliveMusic }
			\new Voice = "soprano1" { \sopranoMusic }
			\new Voice = "soprano2" { \dummyKeepAliveMusic }
            \new Voice { 
                \tempoIndications 
            }
		>>
		\new Lyrics = "lyricsUnderSopranoStaff" { \dummyKeepAliveMusic }

		\new Staff = "alto-staff" <<
			\set Staff.instrumentName = "alto"
            \clef treble
            \new Voice = "dummyKeepAliveVoiceForAltoStaff" { \dummyKeepAliveMusic }
			\new Voice = "alto1" { \altoMusic }
			\new Voice = "alto2" { \dummyKeepAliveMusic }
            \new Voice { 
                % \tempoIndications
            }
		>>
		\new Lyrics = "lyricsUnderAltoStaff"  { \dummyKeepAliveMusic }
		
        \new Lyrics = "lyricsAboveTenorStaff" \with {
          % lyrics above a staff should have this override
          \override VerticalAxisGroup.staff-affinity = #DOWN
        } { \dummyKeepAliveMusic } 
		\new Staff = "tenor-staff" \with{\RemoveEmptyStaves } <<
			\set Staff.instrumentName = "tenor"
            \clef "treble_8"
            \new Voice = "dummyKeepAliveVoiceForTenorStaff" { \dummyKeepAliveMusic }
			\new Voice = "tenor1" {   \tenorMusic            }
            \new Voice = "tenor2" {   \dummyKeepAliveMusic   }
            \new Voice { 
                % \tempoIndications 
            }
		>>
        \new Lyrics = "lyricsUnderTenorStaff" { \dummyKeepAliveMusic } 

        \new StaffGroup = "tenorStaffGroup" 
            \with {\RemoveEmptyStaves }
                <<
                    \new Lyrics = "lyricsAboveTenor1Staff" { \dummyKeepAliveMusic } 
                    \new Staff = "tenor1-staff" \with { } <<
                        \override Staff.VerticalAxisGroup.remove-first = ##t
                        \set Staff.instrumentName = "tenor 1"
                        \set Staff.shortInstrumentName = "tenor 1"
                        \clef "treble_8"
                        \new Voice = "dummyKeepAliveVoiceForTenor1Staff" { \dummyKeepAliveMusic }
                        \new Voice { 
                            % \tempoIndications 
                        }
                    >> 
                    \new Lyrics = "lyricsUnderTenor1Staff" \with { alignBelowContext = #"tenor1-staff" } { \dummyKeepAliveMusic  }                     
                    \new Staff = "tenor2-staff"  \with { }  <<
                        \override Staff.VerticalAxisGroup.remove-first = ##t
                        \set Staff.instrumentName = "tenor 2"
                        \set Staff.shortInstrumentName = "tenor 2"
                        \clef "treble_8" 
                        \new Voice = "dummyKeepAliveVoiceForTenor2Staff" { \dummyKeepAliveMusic }
                        \new Voice { 
                            % \tempoIndications 
                        }
                    >>
                    \new Lyrics = "lyricsUnderTenor2Staff"  \with { alignBelowContext = #"tenor2-staff" } { \dummyKeepAliveMusic  } 
                >>

		\new Staff = "bass-staff"
		<<
			\set Staff.instrumentName = "bass"
            \clef bass
            \new Voice = "dummyKeepAliveVoiceForBassStaff" { \dummyKeepAliveMusic }
			\new Voice = "bass1" {  \bassMusic }
			\new Voice = "bass2" {  \dummyKeepAliveMusic }
            \new Voice { 
                % \tempoIndications 
            }
		>>
		\new Lyrics = "lyricsUnderBassStaff" { \dummyKeepAliveMusic }
		\new Lyrics = "diagnosticLyrics" { \dummyKeepAliveMusic }
        

        \new Lyrics \lyricsto "soprano1"  \sopranoOneLyrics
        \new Lyrics \lyricsto "alto1"     \altoOneLyrics
        \new Lyrics \lyricsto "tenor1"    \tenorOneLyrics
        \new Lyrics \lyricsto "tenor2"    \tenorTwoLyrics
        \new Lyrics \lyricsto "bass1"     \bassOneLyrics
       
       

        % \new Lyrics \lyricsto "tenor2"
        % {
            % \context Lyrics = "diagnosticLyrics" \lyricsto "tenor2" {
                % \numberedSyllableDummyLyrics "t5" 1 100
            % }
        % }
        
	>>
}


\book{
    \header{
        tagline =  "Engraved 2019 in Seattle for The Meridian Ensemble; Yuly Kopkin, Artistic Director"
    }

    \score{

        \transpose c c \scorecontents

        \layout {
            %indent = 1\in

            \context{
                \Staff
                %\remove Instrument_name_engraver
                \override DynamicTextSpanner.dash-period = #0 %removes the dashed lines representing "cresc." crescendos, and similar decrescendoes and diminuendos.
            }

            \context{
                \Lyrics
                 \override LyricText.color=#red
                 % \override LyricText.color=#white
                 \override LyricText.font-size=#-2
            }
            
            \context{
                \Voice
                \autoBeamOff
            }
            
            \context{
                \Score
                \override DynamicText.direction = #UP
                \override DynamicLineSpanner.direction = #UP
            }
        }
        
        \header{
            title = \markup{ \caps {Elegy} } 
            composer = "Vasily Sergeyevich Kalinnikov (1866 – 1901)"
            poet = \markup {
              \column {
                \line {
                  "words by CROBA, A PIRANHA"
                }
                \line {
                    % phonetization for English speakers by Yuly Kopkin
                }
              }
           }
            % arranger = "typeset by Neil Jackson"
            % breakbefore = ##f
        }
        % \midi{  
            % \context {
                % \Score
                % tempoWholesPerMinute = #(ly:make-moment 60 4)	
                % midiMinimumVolume = #0.7
                % midiMaximumVolume = #0.7
                % midiInstrument = #"voice oohs"
            % }
        % }
    }	   
}