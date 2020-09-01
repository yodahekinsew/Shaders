Shader "Yodahe/BumpDiffuse"
{
    Properties
    {
        _diffuseColor ("Diffusive Color", Color) = (1,1,1,1)
        _diffuseTex ("Diffusive Texture", 2D) = "white" {}
        _emissiveColor ("Emission Color", Color) = (1,1,1,1)
        _bumpTex ("Bump Texture", 2D) = "white" {}
        _bumpSlider ("Bump Intensity", Range(0, 10)) = 1
        _bumpScale ("Bump Scale", Range(0, 10)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert

        fixed4 _diffuseColor;
        sampler2D _diffuseTex;
        fixed4 _emissiveColor;
        sampler2D _bumpTex;
        half _bumpSlider;
        half _bumpScale;

        struct Input
        {
            float2 uv_diffuseTex;
            float2 uv_bumpTex;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_diffuseTex, IN.uv_diffuseTex * _bumpScale).rgb * _diffuseColor.rgb;
            o.Emission = _emissiveColor.rgb;
            o.Normal = UnpackNormal(tex2D(_bumpTex, IN.uv_bumpTex * _bumpScale));
            o.Normal *= float3(_bumpSlider, _bumpSlider, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
