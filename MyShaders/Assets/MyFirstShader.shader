﻿Shader "Yodahe/MyFirstShader" {

    Properties {
        _myColor ("Example Color", Color) = (1,1,1,1)
        _myEmission ("Example Emission", Color) = (1,1,1,1)
        _myNormal ("Example Normal", Color) = (1,1,1,1)
    }

    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert

            struct Input {
                float2 uvMainTex;
            };

            fixed4 _myColor;
            fixed4 _myEmission;
            fixed4 _myNormal;

            void surf (Input IN, inout SurfaceOutput o) {
                o.Albedo = _myColor.rgb;
                o.Emission = _myEmission.rgb;
                o.Normal = _myNormal.rgb;
            }

        ENDCG
    }

    FallBack "Diffuse"
}