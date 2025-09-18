Extension { #name : #Class }

{ #category : #'*GToolkit-Pharo-Extensions' }
Class >> gtComment [ 
	"Utility method to handle differences in behaviour between Class>>#comment
	between Pharo 11 and Pharo 12.
	
	In Pharo 11 Class>>#comment returns the default comment if the class has no comment, and in Pharo 12 it returns an empty string. This keeps the behaviour of returning an empty string.
	
	Should be removed and just comment should be used once we no longer need to support Pharo 11"
	
	^ self
		forPharo12AndNewer: [ self comment ]
		forPharo11: [ self organization classComment ].
]

{ #category : #'*GToolkit-Pharo-Extensions' }
Class >> gtMetaFor: aView [
	<gtView>
	^ aView explicit
		title: 'Meta';
		priority: 200;
		stencil: [ (GtCoderElement forClass: self) disablePlayPage ]
]
