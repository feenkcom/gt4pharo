Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoMethodCoder >> asCoderViewModel [
	^ GtPharoMethodCoderViewModel new coder: self
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoMethodCoder >> asExpandedOnlyElement [
	"Create an element for just the expanded coder without expander"

	^ GtPharoMethodCoderExpandedOnlyElement new
		textualCoderViewModel: self asCoderViewModel;
		yourself
]
