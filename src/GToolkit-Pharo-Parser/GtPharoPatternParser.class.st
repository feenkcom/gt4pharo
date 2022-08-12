Class {
	#name : #GtPharoPatternParser,
	#superclass : #GtPharoParser,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #accessing }
GtPharoPatternParser class >> scannerClass [
	^ GtPharoPatternScanner
]
