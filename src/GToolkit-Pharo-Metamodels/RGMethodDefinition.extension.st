Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Pharo-Metamodels' }
RGMethodDefinition >> gtHighlighter [
	^ self annotationNamed: #gtHighlighter
]

{ #category : #'*GToolkit-Pharo-Metamodels' }
RGMethodDefinition >> gtHighlighter: aHighlighter [
	self annotationNamed: #gtHighlighter put: aHighlighter
]

{ #category : #'*GToolkit-Pharo-Metamodels' }
RGMethodDefinition >> hasGtHighlighter [
	^ self hasAnnotationNamed: #gtHighlighter
]

{ #category : #'*GToolkit-Pharo-Metamodels' }
RGMethodDefinition >> methodReference [
	^ self
]
