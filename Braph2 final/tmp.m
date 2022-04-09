clear all
clc

delete([fileparts(which('braph2')) '/src/ds/ETD2.m'])
create_Element([fileparts(which('braph2genesis')) '/src/ds/_ETD2.gen.m'], [fileparts(which('braph2')) '/src/ds'])
