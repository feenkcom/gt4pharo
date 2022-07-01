Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-Pharo-Extensions' }
SequenceableCollection >> takeFirst: anInteger [
	^ self first: (self size min: anInteger)
]
