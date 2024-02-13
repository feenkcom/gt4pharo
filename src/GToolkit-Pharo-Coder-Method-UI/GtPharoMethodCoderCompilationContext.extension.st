Extension { #name : #GtPharoMethodCoderCompilationContext }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoMethodCoderCompilationContext >> gtInfo [
	^ Array 
		with: #targetBehavior -> self targetBehavior 
		withAll: super gtInfo
]
