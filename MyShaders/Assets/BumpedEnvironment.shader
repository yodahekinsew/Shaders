﻿Shader "Yodahe/BumpedEnvironment"
{
    Properties
    {
        _diffuseTex ("Diffusive Texture", 2D) = "white" {}
        _bumpTex ("Bump Texture", 2D) = "white" {}
        _bumpSlider ("Bump Intensity", Range(0, 10)) = 1
        _bright ("Brightness", Range(0, 10)) = 1
        _cube ("Cube Map", CUBE) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _diffuseTex;
        sampler2D _bumpTex;
        half _bumpSlider;
        half _bright;
        samplerCUBE _cube;

        struct Input
        {
            float2 uv_diffuseTex;
            float2 uv_bumpTex;
            float3 worldRefl; INTERNAL_DATA
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
            // o.Albedo = tex2D(_diffuseTex, IN.uv_diffuseTex).rgb;
            o.Normal = UnpackNormal(tex2D(_bumpTex, IN.uv_bumpTex)) * _bright;
            o.Normal *= float3(_bumpSlider, _bumpSlider, 1);
            o.Albedo = texCUBE(_cube, WorldReflectionVector(IN, o.Normal)).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
