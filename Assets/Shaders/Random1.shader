Shader "Learning/Random1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RandomMultiplier("Random Multiplier", Range(100,100000)) = 100
        _Offset_X("_Offset_X", float) = 1.0
        _Offset_Y("_Offset_Y", float) = 1.0
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

            #include "UnityCG.cginc"

            struct VertexData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _RandomMultiplier;
            float _Offset_X;
            float _Offset_Y;

            v2f vert (VertexData v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            float random(float2 p)
            {
                float d = dot(p, float2(_Offset_X, _Offset_Y));
                float s = sin(d);
                return frac(s * 65124.6234125);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv * 20;
                float2 id = floor(uv);
                float rnd = random(i.uv);
                return fixed4(rnd, rnd, rnd, 1);
            }
            ENDCG
        }
    }
}
