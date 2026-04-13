Extension { #name : #BlRunRopedText }

{ #category : #'*GToolkit-Pharo-Extensions' }
BlRunRopedText >> withNoLineLongerThan: aNumber [
	"For compatibility with Morph>>#setBalloonText:maxLineLength:"
	^ self class string:  (self asString withNoLineLongerThan: aNumber)
]
