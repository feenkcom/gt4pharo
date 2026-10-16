"
I am a baseline used only by examples of rename controllers, see {{gtClass:GtPharoRenameBaselineCoderController}} and {{gtClass:GtPharoRenamePackageCoderController}}. The baseline {{gtClass:BaselineOfGtPharoDummyBaselineTarget}} exists so that the baseline name in {{gtMethod:GtPharoDummyBaseline>>#baseline:}} is a valid baseline name.
"
Class {
	#name : #GtPharoDummyBaseline,
	#superclass : #BaselineOf,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #baseline }
GtPharoDummyBaseline >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec baseline: 'GtPharoDummyBaselineTarget' with: [ spec repository: 'github://feenkcom/gtoolkit-dummy/src' ].
			spec package: 'GToolkit-Pharo-Coder-Examples'.
			spec group: 'Default' with: #('GToolkit-Pharo-Coder-Examples' 'GtPharoDummyBaselineTarget') ]
]
