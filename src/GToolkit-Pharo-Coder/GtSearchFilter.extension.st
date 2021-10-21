Extension { #name : #GtSearchFilter }

{ #category : #'*GToolkit-Pharo-Coder' }
GtSearchFilter >> methodPackages [

	| aResult |
	aResult := OrderedCollection new.

	self do: [ :eachMethod | 
		| aSearchPackage aMethodPackage |
		aMethodPackage := eachMethod package.

		(aResult anySatisfy: [ :eachSearchPackage | 
			 eachSearchPackage package = aMethodPackage ]) ifFalse: [ 
			aSearchPackage := GtSearchPackage new
				                  package: aMethodPackage;
				                  group: self.
			aResult add: aSearchPackage ] ].
			
	^ aResult
]
