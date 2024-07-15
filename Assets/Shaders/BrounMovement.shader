Shader "Learning/BrounMovement"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _SinAmp("Amplitude", float) = 1.0
        _SinFreq("Frequency", float) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _SinAmp;
            float _SinFreq;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = 0;
                float x = i.uv.x;
                col = sin(x * _SinFreq);
                float t = 0.01 * (_Time.y * 100.0);
                col += sin(x * _SinFreq * 1.3 + t) * 5.5;
                col += sin(x * _SinFreq * 1.6 + t * 1.162) * 4.5;
                col += sin(x * _SinFreq * 2.21 + t * 4.32) * 3.5;
                col += sin(x * _SinFreq * 3.4 + t * 2.169) * 2.5;
                col *= _SinAmp * 0.06;
                return col;
            }
            ENDCG
        }
    }
}
