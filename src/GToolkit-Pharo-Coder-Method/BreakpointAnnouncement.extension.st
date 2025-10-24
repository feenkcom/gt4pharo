Extension { #name : #BreakpointAnnouncement }

{ #category : #'*GToolkit-Pharo-Coder-Method' }
BreakpointAnnouncement >> gtAffectsMethod: aMethod [
	^ self link methods
		anySatisfy: [ :eachMethod | 
			eachMethod compiledMethod == aMethod compiledMethod
				or: [ eachMethod compiledMethod methodClass isAnonymous
						and: [ (eachMethod compiledMethod methodClass
								inheritsFrom: aMethod compiledMethod methodClass)
								and: [ eachMethod compiledMethod selector = aMethod compiledMethod selector ] ] ] ]
]
